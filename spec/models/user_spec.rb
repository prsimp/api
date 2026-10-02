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

    it "is unique" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.username = "something"
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
  end

  describe "location" do
    it "is required" do
      @user.location = ""
      expect(@user).not_to be_valid
    end
  end
end
