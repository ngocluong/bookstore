# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name { Faker::Name.name }
    sort_order { rand(0..5) }
  end
end
