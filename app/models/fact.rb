class Fact < ApplicationRecord
  belongs_to :user, optional: true

  validates_presence_of :body, :fact_type, :title

  scope :no_random, -> { where("fact_type != ?", "Random") }

  def self.kind(fact_type)
    where("fact_type = ?", fact_type)
  end

  def self.random
    kind("Random").reorder(Arel.sql("RANDOM()")).first
  end
end
