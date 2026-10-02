require 'rails_helper'

RSpec.describe Fact do
  before do
    @fact = FactoryBot.build(:fact)
  end

  subject { @fact }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :fact_type }
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :body }

  describe "fact_type" do
    it "is required" do
      @fact.fact_type = nil
      expect(@fact).not_to be_valid
    end
  end

  describe "title" do
    it "is required" do
      @fact.title = ""
      expect(@fact).not_to be_valid
    end
  end

  describe "body" do
    it "is required" do
      @fact.body = ""
      expect(@fact).not_to be_valid
    end
  end
end
