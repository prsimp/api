require 'rails_helper'

RSpec.describe ProfilesController do
  render_views

  before do
    @user = FactoryBot.create(:user)
    @github = @user.profiles.create!(site: "Github", username: "test", profile_url: "https://github.com/test/")
    @lastfm = @user.profiles.create!(site: "Last.fm", username: "test", profile_url: "http://www.last.fm/user/test")
  end

  describe "GET 'index'" do
    it "responds successfully" do
      get :index, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
    end

    it "returns the user's profiles in order" do
      get :index, params: { user_id: @user.username }, format: :json
      result = JSON.parse(response.body)
      expect(result["username"]).to eq(@user.username)
      expect(result["profiles"].map { |profile| profile["site"] }).to eq(["Github", "Last.fm"])
    end

    it "returns a 404 for an unknown user" do
      get :index, params: { user_id: "nobody" }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq("error" => "Record could not be found")
    end
  end

  describe "GET 'show'" do
    it "returns a single profile" do
      get :show, params: { user_id: @user.username, id: @lastfm.id }, format: :json
      expect(response).to be_successful
      profile = JSON.parse(response.body)["profile"]
      expect(profile["profile_url"]).to eq("http://www.last.fm/user/test")
      expect(profile["url"]).to end_with("/users/#{@user.username}/profiles/#{@lastfm.id}")
    end

    it "returns a 404 for an unknown profile" do
      get :show, params: { user_id: @user.username, id: 0 }, format: :json
      expect(response).to have_http_status(:not_found)
    end

    it "does not return another user's profile" do
      other_profile = FactoryBot.create(:user).profiles.create!(site: "Github", username: "other",
                                                                profile_url: "https://github.com/other/")
      get :show, params: { user_id: @user.username, id: other_profile.id }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
