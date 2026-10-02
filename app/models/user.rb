class User < ApplicationRecord
  has_many :profiles, -> { order(:id) }, dependent: :destroy
  has_many :facts, -> { order(:id) }, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :age, :email, :location, :name, :username
  validates_numericality_of :age, only_integer: true, greater_than: 0
  validates :name, length: { maximum: 50 }
  validates :username, length: { maximum: 20 },
                       uniqueness: { case_sensitive: false }
  validates :email, format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
