require 'rails_helper'

RSpec.describe Profile do
  before do
    @profile = FactoryBot.build(:profile)
  end

  subject { @profile }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :site }
  it { is_expected.to respond_to :username }
  it { is_expected.to respond_to :profile_url }

  describe "site" do
    it "is required" do
      @profile.site = ""
      expect(@profile).not_to be_valid
    end
  end

  describe "username" do
    it "is required" do
      @profile.username = ""
      expect(@profile).not_to be_valid
    end
  end

  describe "profile_url" do
    it "is required" do
      @profile.profile_url = ""
      expect(@profile).not_to be_valid
    end

    it "is formatted as an profile_url" do
      @profile.profile_url = "foo"
      expect(@profile).not_to be_valid
    end
  end
end
