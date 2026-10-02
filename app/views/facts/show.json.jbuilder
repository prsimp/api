json.username @user.username
json.url username_url(@user)
json.fact do
  json.partial! 'facts/fact', fact: @fact
end
