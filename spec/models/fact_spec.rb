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

  describe "finders" do
    before do
      @user = FactoryBot.create(:user)
      @hire = @user.facts.create!(fact_type: "Hire", title: "Hungry", body: "Hungry to learn")
      @recent = @user.facts.create!(fact_type: "Recent", title: "US Army", body: "Infantry Officer")
      @tomatoes = @user.facts.create!(fact_type: "Random", title: "Tomatoes", body: "Can't stand them")
      @bananas = @user.facts.create!(fact_type: "Random", title: "Bananas", body: "Likes them")
    end

    describe ".no_random" do
      it "leaves out the random facts" do
        expect(@user.facts.no_random).to eq([@hire, @recent])
      end
    end

    describe ".kind" do
      it "returns only facts of that type" do
        expect(@user.facts.kind("Recent")).to eq([@recent])
        expect(@user.facts.kind("Random")).to eq([@tomatoes, @bananas])
      end
    end

    describe ".random" do
      it "returns one of the random facts" do
        expect([@tomatoes, @bananas]).to include(@user.facts.random)
      end

      it "picks among them rather than always the first" do
        picks = Array.new(30) { @user.facts.random }
        expect(picks.uniq).to contain_exactly(@tomatoes, @bananas)
      end

      it "returns nil when there are no random facts" do
        @tomatoes.destroy
        @bananas.destroy
        expect(@user.facts.random).to be_nil
      end
    end
  end
end
