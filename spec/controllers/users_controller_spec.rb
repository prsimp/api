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

    it "returns a 404 when there are no users" do
      @user.destroy
      get :index, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq("error" => "Record could not be found")
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

    it "returns a 404 for an unknown user" do
      get :show, params: { id: "nobody" }, format: :json
      expect(response).to have_http_status(:not_found)
    end

    it "leaves out profiles and facts when the user has none" do
      get :show, params: { id: @user.username }, format: :json
      result = JSON.parse(response.body)
      expect(result).not_to have_key("profiles")
      expect(result).not_to have_key("facts")
    end

    it "includes profiles and every fact except the random ones" do
      @user.profiles.create!(site: "Github", username: "test", profile_url: "https://github.com/test/")
      @user.facts.create!(fact_type: "Hire", title: "Hungry", body: "Hungry to learn")
      @user.facts.create!(fact_type: "Random", title: "Vans", body: "Loves classic Vans")
      get :show, params: { id: @user.username }, format: :json
      result = JSON.parse(response.body)
      expect(result["profiles"].map { |profile| profile["site"] }).to eq(["Github"])
      expect(result["facts"].map { |fact| fact["title"] }).to eq(["Hungry"])
    end
  end

  describe "GET 'whois'" do
    it "responds successfully" do
      get :whois, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
    end

    it "returns a 404 for an unknown user" do
      get :whois, params: { user_id: "nobody" }, format: :json
      expect(response).to have_http_status(:not_found)
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
