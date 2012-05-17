class ProfilesController < ApplicationController
  def index
    @user = User.find_by_username!(params[:user_id])
    @profiles = @user.profiles
  end

  def show
    @user = User.find_by_username!(params[:user_id])
    @profile = @user.profiles.find(params[:id])
  end
end
