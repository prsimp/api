class FactsController < ApplicationController
  def index
    @user = User.find_by_username!(params[:user_id])
    @facts = @user.facts.no_random
  end

  def show
    @user = User.find_by_username!(params[:user_id])
    @fact = @user.facts.find(params[:id])
  end

  def background
    @user = User.find_by_username!(params[:user_id])
    @background = @user.facts.kind("Background")
    @recent = @user.facts.kind("Recent")
  end

  def whyharvest
    @user = User.find_by_username!(params[:user_id])
    @facts = @user.facts.kind("Harvest")
    render 'fact'
  end

  def whyhire
    @user = User.find_by_username!(params[:user_id])
    @facts = @user.facts.kind("Hire")
    render 'fact'
  end

  def random
    @user = User.find_by_username!(params[:user_id])
    @facts = @user.facts.random
    render 'fact'
  end
end
