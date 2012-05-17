require 'spec_helper'

describe ApplicationHelper do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "username_url" do
    it "returns the correct url" do
      result = URI.parse(username_url(@user)).path
      result.should == "/users/#{@user.username}"
    end
  end

  describe "username_whois_url" do
    it "returns the correct url" do
      result = URI.parse(username_whois_url(@user)).path
      result.should == "/users/#{@user.username}/whois"
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
      result.should == "/users/#{@user.username}/profiles/1"
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
      result.should == "/users/#{@user.username}/facts/1"
    end
  end
end