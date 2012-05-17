class UsersController < ApplicationController
  def index
    @users = User.all
    raise ActiveRecord::RecordNotFound if @users.empty?
  end

  def show
    @user = User.find_by_username!(params[:id])
    @facts = @user.facts.no_random
  end

  def whois
    @user = User.find_by_username!(params[:user_id])
  end
end
