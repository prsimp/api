require 'spec_helper'

describe UsersController do
  render_views

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "GET 'index'" do
    it "responds successfully" do
      get :index
      response.should be_success
    end

    it "returns an array of JSON users" do
      get :index
      result = JSON.parse(response.body).first
      result["username"].should == @user.username
    end
  end

  describe "GET 'show'" do
    it "responds successfully" do
      get :show, id: @user.username
      response.should be_success
    end

    it "returns a single user" do
      get :show, id: @user.username
      result = JSON.parse(response.body)
      result["name"].should == @user.name
      result["email"].should == @user.email
    end
  end

  describe "GET 'whois'" do
    it "responds successfully" do
      get :whois, user_id: @user.username
      response.should be_success
    end

    describe "returns only basic biographical info" do
      it "does not contain any profiles" do
        get :whois, user_id: @user.username
        result = JSON.parse(response.body)
        result.should_not be_has_key("profiles")
      end

      it "does not contain any facts" do
        get :whois, user_id: @user.username
        result = JSON.parse(response.body)
        result.should_not be_has_key("facts")
      end
    end
  end
end
