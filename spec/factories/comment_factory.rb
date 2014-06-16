# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    rating { rand(1..5) }
    content { Faker::Lorem.sentence }
    book
    user
  end
end
