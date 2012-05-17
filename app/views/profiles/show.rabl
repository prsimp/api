object @user
node(:url) { |user| username_url(user) }
attributes :username
child @profile => :profile do
  attributes :site, :username, :id, :profile_url
  node(:url) { |profile| username_profile_url(@user, profile) }
end