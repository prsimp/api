object @user
node(:url) { |user| username_url(user) }
attributes :name, :email, :username, :age, :location