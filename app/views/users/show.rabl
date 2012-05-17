object @user
node(:url) { |user| username_url(user) }
node(:whois_url) { |user| username_whois_url(user) }
attributes :name, :email, :username, :age, :location, :id
child :profiles, :if => lambda { |user| user.profiles.count > 0 } do
  attributes :site, :username, :profile_url, :id
  node(:url) { |profile| username_profile_url(@user, profile) }
end
child @facts, :if => lambda { |user| user.facts.count > 0 } do
  attributes :title, :body, :fact_type, :id
  node(:url) { |fact| username_fact_url(@user, fact) }
end