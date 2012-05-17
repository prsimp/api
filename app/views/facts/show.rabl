object @user
node(:url) { |user| username_url(user) }
attributes :username
child @fact => :fact do
  attributes :fact_type, :title, :body, :id
  node(:url) { |fact| username_fact_url(@user, fact) }
end