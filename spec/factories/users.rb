FactoryBot.define do
  factory :user do
    name      { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
    username  { (name.split[0][0..2] + name.split[1]).sub(/[^a-z]/i,'').downcase }
    email     { "#{username}@example.com" }
    age       { Random.new.rand(18..65) }
    location  { "#{FFaker::Address.city}, #{FFaker::AddressUS.state}" }
  end
end
