require 'rails_helper'

# Locks in the JSON contract. The fixtures in spec/fixtures/api were captured
# from the original Rails 3.2 app running against the same seeds.
RSpec.describe "The Paul Simpson API" do
  def golden(name)
    JSON.parse(Rails.root.join("spec/fixtures/api/#{name}.json").read)
  end

  def json
    JSON.parse(response.body)
  end

  before do
    %w[users profiles facts].each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
    FFaker::Random.seed = 2012
    load Rails.root.join("db/seeds.rb")
  end

  {
    "/users/prsimp" => "prsimp",
    "/users/prsimp/whois" => "prsimp_whois",
    "/users/prsimp/profiles" => "prsimp_profiles",
    "/users/prsimp/profiles/1" => "prsimp_profiles_1",
    "/users/prsimp/facts" => "prsimp_facts",
    "/users/prsimp/facts/1" => "prsimp_facts_1",
    "/users/prsimp/background" => "prsimp_background",
    "/users/prsimp/whyharvest" => "prsimp_whyharvest",
    "/users/prsimp/whyhire" => "prsimp_whyhire"
  }.each do |path, name|
    describe "GET #{path}" do
      it "matches the original response" do
        get path
        expect(response).to have_http_status(:ok)
        expect(json).to eq(golden(name))
      end

      it "is the same with a .json extension" do
        get "#{path}.json"
        expect(json).to eq(golden(name))
      end
    end
  end

  describe "GET /users" do
    it "lists every user with links" do
      get "/users"
      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(100)
      expect(json.map(&:keys).uniq).to eq([%w[username url whois_url]])
      expect(json).to include(
        "username" => "prsimp",
        "url" => "http://www.example.com/users/prsimp",
        "whois_url" => "http://www.example.com/users/prsimp/whois"
      )
    end
  end

  describe "GET /users/prsimp/random" do
    it "returns one random fact" do
      get "/users/prsimp/random"
      expect(response).to have_http_status(:ok)
      expect(json.keys).to eq(%w[username url fact])
      expect(json["fact"].keys).to eq(%w[fact_type title body id url])
      expect(json["fact"]["fact_type"]).to eq("Random")
      expect(json["fact"]["url"]).to eq("http://www.example.com/users/prsimp/facts/#{json["fact"]["id"]}")
    end
  end

  [
    "/users/nobody",
    "/users/nobody/whois",
    "/users/prsimp/facts/9999",
    "/users/prsimp/profiles/9999"
  ].each do |path|
    describe "GET #{path}" do
      it "returns a JSON 404" do
        get path
        expect(response).to have_http_status(:not_found)
        expect(json).to eq(golden("not_found"))
      end
    end
  end

  it "answers browsers with JSON" do
    get "/users/prsimp", headers: { "Accept" => "text/html,application/xhtml+xml,*/*;q=0.8" }
    expect(json).to eq(golden("prsimp"))
  end
end
