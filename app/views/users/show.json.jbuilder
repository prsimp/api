json.(@user, :name, :email, :username, :age, :location, :id)
json.url username_url(@user)
json.whois_url username_whois_url(@user)
if @user.profiles.count > 0
  json.profiles @user.profiles do |profile|
    json.(profile, :site, :username, :profile_url, :id)
    json.url username_profile_url(@user, profile)
  end
end
if @user.facts.count > 0
  json.facts @facts do |fact|
    json.(fact, :title, :body, :fact_type, :id)
    json.url username_fact_url(@user, fact)
  end
end
