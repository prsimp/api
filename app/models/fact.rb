class Fact < ActiveRecord::Base
  belongs_to :user

  attr_accessible :body, :fact_type, :title

  validates_presence_of :body, :fact_type, :title

  scope :no_random, where("fact_type != ?", "Random")

  def self.kind(fact_type)
    where("fact_type = ?", fact_type)
  end

  def self.random
    self.kind("Random").first(order: "RANDOM()")
  end
end
