require 'rails_helper'

RSpec.describe ApplicationHelper do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "username_url" do
    it "returns the correct url" do
      result = URI.parse(username_url(@user)).path
      expect(result).to eq("/users/#{@user.username}")
    end
  end

  describe "username_whois_url" do
    it "returns the correct url" do
      result = URI.parse(username_whois_url(@user)).path
      expect(result).to eq("/users/#{@user.username}/whois")
    end
  end

  describe "username_profile_url" do
    before do
      @user.profiles.build(site: "Github",
                           username: "test",
                           profile_url: "https://github.com/test/")
      @user.save
    end

    it "returns the correct url" do
      profile = @user.profiles.first
      result = URI.parse(username_profile_url(@user, profile)).path
      expect(result).to eq("/users/#{@user.username}/profiles/#{profile.id}")
    end
  end

  describe "username_fact_url" do
    before do
      @user.facts.build(fact_type: 1,
                        title: "test",
                        body: "This is a test fact")
      @user.save
    end

    it "returns the correct url" do
      fact = @user.facts.first
      result = URI.parse(username_fact_url(@user, fact)).path
      expect(result).to eq("/users/#{@user.username}/facts/#{fact.id}")
    end
  end
end
