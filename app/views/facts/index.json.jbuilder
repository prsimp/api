json.username @user.username
json.url username_url(@user)
json.facts @facts, partial: 'facts/fact', as: :fact
