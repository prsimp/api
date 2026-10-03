require 'rails_helper'

RSpec.describe FactsController do
  render_views

  before do
    @user = FactoryBot.create(:user)
    @harvest = @user.facts.create!(fact_type: "Harvest", title: "Coworkers", body: "Passionate people")
    @hire = @user.facts.create!(fact_type: "Hire", title: "Hungry", body: "Hungry to learn")
    @background = @user.facts.create!(fact_type: "Background", title: "Self-Taught", body: "Basic Ruby")
    @recent = @user.facts.create!(fact_type: "Recent", title: "US Army", body: "Infantry Officer")
    @random = @user.facts.create!(fact_type: "Random", title: "Vans", body: "Loves classic Vans")
  end

  def titles(facts)
    facts.map { |fact| fact["title"] }
  end

  describe "GET 'index'" do
    it "responds successfully" do
      get :index, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
    end

    it "returns every fact except the random ones" do
      get :index, params: { user_id: @user.username }, format: :json
      result = JSON.parse(response.body)
      expect(result["username"]).to eq(@user.username)
      expect(titles(result["facts"])).to eq(["Coworkers", "Hungry", "Self-Taught", "US Army"])
    end

    it "returns a 404 for an unknown user" do
      get :index, params: { user_id: "nobody" }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq("error" => "Record could not be found")
    end
  end

  describe "GET 'show'" do
    it "returns a single fact" do
      get :show, params: { user_id: @user.username, id: @hire.id }, format: :json
      expect(response).to be_successful
      fact = JSON.parse(response.body)["fact"]
      expect(fact["title"]).to eq("Hungry")
      expect(fact["url"]).to end_with("/users/#{@user.username}/facts/#{@hire.id}")
    end

    it "returns a 404 for an unknown fact" do
      get :show, params: { user_id: @user.username, id: 0 }, format: :json
      expect(response).to have_http_status(:not_found)
    end

    it "does not return another user's fact" do
      other_fact = FactoryBot.create(:user).facts.create!(fact_type: "Hire", title: "Other", body: "Not yours")
      get :show, params: { user_id: @user.username, id: other_fact.id }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET 'background'" do
    it "splits background and recent facts" do
      get :background, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
      result = JSON.parse(response.body)
      expect(titles(result["background"])).to eq(["Self-Taught"])
      expect(titles(result["recent"])).to eq(["US Army"])
      expect(result["background"].first).not_to have_key("fact_type")
    end
  end

  describe "GET 'whyharvest'" do
    it "returns only the Harvest facts" do
      get :whyharvest, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
      expect(titles(JSON.parse(response.body)["facts"])).to eq(["Coworkers"])
    end
  end

  describe "GET 'whyhire'" do
    it "returns only the Hire facts" do
      get :whyhire, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
      expect(titles(JSON.parse(response.body)["facts"])).to eq(["Hungry"])
    end
  end

  describe "GET 'random'" do
    it "returns a random fact" do
      get :random, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["fact"]["title"]).to eq("Vans")
    end

    it "leaves out the fact when the user has no random facts" do
      @random.destroy
      get :random, params: { user_id: @user.username }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)).not_to have_key("fact")
    end
  end
end
