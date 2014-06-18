# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
  end
end
