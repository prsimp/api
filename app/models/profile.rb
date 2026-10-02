class Profile < ApplicationRecord
  belongs_to :user, optional: true

  validates_presence_of :site, :profile_url, :username
  validates :profile_url, format: { with: URI::RFC2396_PARSER.make_regexp(%w(http https)) }
end
