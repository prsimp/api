require 'rails_helper'

RSpec.describe UsersController do
  render_views

  before do
    @user = FactoryBot.create(:user)
  end

  describe "GET 'index'" do
    it "responds successfully" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns an array of JSON users" do
      get :index, format: :json
      result = JSON.parse(response.body).first
      expect(result["username"]).to eq(@user.username)
    end
  end

  describe "GET 'show'" do
    it "responds successfully" do
      get :show, params: { id: @user.username }, format: :json
      expect(response).to be_successful
    end

    it "returns a single user" do
      get :show, params: { id: @user.username }, format: :json
      result = JSON.parse(response.body)
      expect(result["name"]).to eq(@user.name)
      expect(result["email"]).to eq(@user.email)
    end
  end

  describe "GET 'whois'" do
    it "responds successfully" do
      get :whois, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
    end

    describe "returns only basic biographical info" do
      it "does not contain any profiles" do
        get :whois, params: { user_id: @user.username }, format: :json
        result = JSON.parse(response.body)
        expect(result).not_to have_key("profiles")
      end

      it "does not contain any facts" do
        get :whois, params: { user_id: @user.username }, format: :json
        result = JSON.parse(response.body)
        expect(result).not_to have_key("facts")
      end
    end
  end
end
