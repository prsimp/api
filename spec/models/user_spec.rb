require 'rails_helper'

RSpec.describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  subject { @user }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :id }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :username }
  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :age }
  it { is_expected.to respond_to :location }

  describe "name" do
    it "is required" do
      @user.name = ""
      expect(@user).not_to be_valid
    end

    it "is not greater than 50 characters" do
      @user.name = "x" * 51
      expect(@user).not_to be_valid
    end
  end

  describe "username" do
    it "is required" do
      @user.username = ""
      expect(@user).not_to be_valid
    end

    it "is not greater than 20 characters" do
      @user.username = "x" * 21
      expect(@user).not_to be_valid
    end

    it "is unique" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.email = "something@example.com"
      expect(duplicate_user).not_to be_valid
    end

    it "is unique regardless of case" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.username = @user.username.upcase
      duplicate_user.email = "something@example.com"
      expect(duplicate_user).not_to be_valid
    end
  end

  describe "email" do
    it "is required" do
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "is a valid email" do
      @user.email = "test@example"
      expect(@user).not_to be_valid
    end

    it "accepts dots, plus signs and subdomains" do
      @user.email = "first.last+harvest@mail.example.co.uk"
      expect(@user).to be_valid
    end

    it "is unique" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.username = "something"
      expect(duplicate_user).not_to be_valid
    end

    it "is unique regardless of case" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.username = "something"
      duplicate_user.email = @user.email.upcase
      expect(duplicate_user).not_to be_valid
    end
  end

  describe "age" do
    it "is required" do
      @user.age = nil
      expect(@user).not_to be_valid
    end

    it "is a number" do
      @user.age = "forty two"
      expect(@user).not_to be_valid
    end

    it "is greater than zero" do
      @user.age = -42
      expect(@user).not_to be_valid
    end

    it "is a whole number" do
      @user.age = 27.5
      expect(@user).not_to be_valid
    end
  end

  describe "location" do
    it "is required" do
      @user.location = ""
      expect(@user).not_to be_valid
    end
  end

  describe "associations" do
    before do
      @user.save!
      @first_fact = @user.facts.create!(fact_type: "Hire", title: "Hungry", body: "Hungry to learn")
      @second_fact = @user.facts.create!(fact_type: "Hire", title: "Calm", body: "Comfortable out of depth")
      @first_profile = @user.profiles.create!(site: "Github", username: "test", profile_url: "https://github.com/test/")
      @second_profile = @user.profiles.create!(site: "Twitter", username: "test", profile_url: "https://twitter.com/test")
    end

    # PostgreSQL writes an updated row to the end of the table, so without an
    # explicit ORDER BY the first record would come back last.
    it "returns facts in id order after an update" do
      @first_fact.update!(body: "Hungry to learn and grow")
      expect(@user.reload.facts).to eq([@first_fact, @second_fact])
    end

    it "returns profiles in id order after an update" do
      @first_profile.update!(username: "prsimp")
      expect(@user.reload.profiles).to eq([@first_profile, @second_profile])
    end

    it "destroys facts and profiles along with the user" do
      expect { @user.destroy }.to change(Fact, :count).by(-2).and change(Profile, :count).by(-2)
    end
  end
end
