json.array! @users do |user|
  json.username user.username
  json.url username_url(user)
  json.whois_url username_whois_url(user)
end
