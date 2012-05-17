require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end

  subject { @user }

  it { should be_valid }
  it { should respond_to :id }
  it { should respond_to :name }
  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :age }
  it { should respond_to :location }

  describe "name" do
    it "is required" do
      @user.name = ""
      @user.should_not be_valid
    end

    it "is not greater than 50 characters" do
      @user.name = "x" * 51
      @user.should_not be_valid
    end
  end

  describe "username" do
    it "is required" do
      @user.username = ""
      @user.should_not be_valid
    end

    it "is not greater than 20 characters" do
      @user.username = "x" * 21
      @user.should_not be_valid
    end

    it "is unique" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.email = "something@example.com"
      duplicate_user.should_not be_valid
    end
  end

  describe "email" do
    it "is required" do
      @user.email = ""
      @user.should_not be_valid
    end

    it "is a valid email" do
      @user.email = "test@example"
      @user.should_not be_valid
    end

    it "is unique" do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.username = "something"
      duplicate_user.should_not be_valid
    end
  end

  describe "age" do
    it "is required" do
      @user.age = nil
      @user.should_not be_valid
    end

    it "is a number" do
      @user.age = "forty two"
      @user.should_not be_valid
    end

    it "is greater than zero" do
      @user.age = -42
      @user.should_not be_valid
    end
  end

  describe "location" do
    it "is required" do
      @user.location = ""
      @user.should_not be_valid
    end
  end
end
