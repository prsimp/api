FactoryGirl.define do
  factory :user do
    name      "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    username  { (name.split[0][0..2] + name.split[1]).sub(/[^a-z]/i,'').downcase }
    email     { "#{username}@example.com" }
    age       Random.new.rand(18..65)
    location  "#{Faker::Address.city}, #{Faker::AddressUS.state}"
  end
end