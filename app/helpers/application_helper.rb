module ApplicationHelper
  def username_url(user)
    user_url(user).sub(/\d+\z/,user.username)
  end

  def username_whois_url(user)
    user_whois_url(user).sub(/users\/\d+/, "users/#{user.username}")
  end

  def username_profile_url(user, profile)
    user_profile_url(user, profile).sub(/users\/\d+/, "users/#{user.username}")
  end

  def username_fact_url(user, fact)
    user_fact_url(user, fact).sub(/users\/\d+/, "users/#{user.username}")
  end
end
