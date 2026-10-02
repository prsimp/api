json.username @user.username
json.url username_url(@user)
if @fact
  json.fact do
    json.partial! 'facts/fact', fact: @fact
  end
end
