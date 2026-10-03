#!/usr/bin/env bash
# Boot an image against a throwaway PostgreSQL and check that it serves the
# seeded API exactly as recorded in spec/fixtures/api.
# Usage: scripts/smoke-test.sh <image> [host-port]
set -euo pipefail

image=$1
port=${2:-3080}
fixtures="$(cd "$(dirname "$0")/.." && pwd)/spec/fixtures/api"
run="api-smoke-$$"

# shellcheck disable=SC2329 # invoked by the EXIT trap below
cleanup() {
  status=$?
  if [ "$status" -ne 0 ]; then
    echo "--- app logs"
    docker logs "$run-app" 2>&1 | tail -50 || true
  fi
  docker rm -f "$run-app" "$run-db" >/dev/null 2>&1 || true
  docker network rm "$run" >/dev/null 2>&1 || true
  exit "$status"
}
trap cleanup EXIT

docker network create "$run" >/dev/null
docker run -d --name "$run-db" --network "$run" \
  -e POSTGRES_USER=api -e POSTGRES_PASSWORD=api -e POSTGRES_DB=api_production \
  postgres:17-alpine >/dev/null

echo "Waiting for PostgreSQL"
for _ in $(seq 1 60); do
  docker exec "$run-db" pg_isready -U api -d api_production >/dev/null 2>&1 && break
  sleep 1
done
docker exec "$run-db" pg_isready -U api -d api_production

docker run -d --name "$run-app" --network "$run" -p "127.0.0.1:$port:3000" \
  -e DATABASE_URL="postgres://api:api@$run-db:5432/api_production" \
  -e SECRET_KEY_BASE="$(openssl rand -hex 64)" \
  "$image" >/dev/null

# The entrypoint runs db:prepare, which loads the schema and seeds an empty
# database before the server starts.
echo "Waiting for the app"
base="http://127.0.0.1:$port"
for _ in $(seq 1 90); do
  curl -fsS -o /dev/null "$base/users/prsimp/whois" 2>/dev/null && break
  sleep 1
done

# Production assumes TLS, so links come back as https. Normalise the scheme
# and compare against the fixtures, which were recorded over plain http.
failed=0
check() {
  local path=$1 name=$2 expected=${3:-200} body status
  body=$(mktemp)
  status=$(curl -s -o "$body" -w '%{http_code}' -H 'Host: www.example.com' "$base$path")
  if [ "$status" = "$expected" ] &&
    diff <(jq -S . "$fixtures/$name.json") \
      <(sed 's#https://www\.example\.com#http://www.example.com#g' "$body" | jq -S .); then
    echo "ok   $path ($status)"
  else
    echo "FAIL $path (status $status, expected $expected)"
    failed=1
  fi
  rm -f "$body"
}

check /users/prsimp prsimp
check /users/prsimp/whois prsimp_whois
check /users/prsimp/background prsimp_background
check /users/nobody not_found 404

exit "$failed"
