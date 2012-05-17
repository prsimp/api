class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :site, :profile_url, :username

  validates_presence_of :site, :profile_url, :username
  validates :profile_url, format: { with: URI::regexp(%w(http https)) }
end
