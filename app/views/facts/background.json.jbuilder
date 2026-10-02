json.username @user.username
json.url username_url(@user)
json.background @background do |fact|
  json.(fact, :title, :body, :id)
  json.url username_fact_url(@user, fact)
end
json.recent @recent do |fact|
  json.(fact, :title, :body, :id)
  json.url username_fact_url(@user, fact)
end
