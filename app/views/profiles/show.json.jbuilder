json.username @user.username
json.url username_url(@user)
json.profile do
  json.partial! 'profiles/profile', profile: @profile
end
