require 'spec_helper'

describe Profile do
  before do
    @profile = FactoryGirl.build(:profile)
  end

  subject { @profile }

  it { should be_valid }
  it { should respond_to :site }
  it { should respond_to :username }
  it { should respond_to :profile_url }

  describe "site" do
    it "is required" do
      @profile.site = ""
      @profile.should_not be_valid
    end
  end

  describe "username" do
    it "is required" do
      @profile.username = ""
      @profile.should_not be_valid
    end
  end

  describe "profile_url" do
    it "is required" do
      @profile.profile_url = ""
      @profile.should_not be_valid
    end

    it "is formatted as an profile_url" do
      @profile.profile_url = "foo"
      @profile.should_not be_valid
    end
  end
end
