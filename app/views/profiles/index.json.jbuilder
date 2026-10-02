json.username @user.username
json.url username_url(@user)
json.profiles @profiles, partial: 'profiles/profile', as: :profile
