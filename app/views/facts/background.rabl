object @user
node(:url) { |user| username_url(user) }
attributes :username
child @background => :background do
  attributes :title, :body, :id
  node(:url) { |fact| username_fact_url(@user, fact) }
end
child @recent => :recent do
  attributes :title, :body, :id
  node(:url) { |fact| username_fact_url(@user, fact) }
end