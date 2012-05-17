collection @users
attributes :username
node(:url) { |user| username_url(user) }
node(:whois_url) { |user| username_whois_url(user) }