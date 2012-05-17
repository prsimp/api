require 'spec_helper'

describe Fact do
  before do
    @fact = FactoryGirl.build(:fact)
  end

  subject { @fact }

  it { should be_valid }
  it { should respond_to :fact_type }
  it { should respond_to :title }
  it { should respond_to :body }

  describe "fact_type" do
    it "is required" do
      @fact.fact_type = nil
      @fact.should_not be_valid
    end
  end

  describe "title" do
    it "is required" do
      @fact.title = ""
      @fact.should_not be_valid
    end
  end

  describe "body" do
    it "is required" do
      @fact.body = ""
      @fact.should_not be_valid
    end
  end
end
