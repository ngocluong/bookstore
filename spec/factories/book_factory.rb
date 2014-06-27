# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence (:title) { |n| "#{n} #{Faker::Name.name}" }
    description { Faker::Lorem.sentence }
    image_url "default.png"
    author_name { Faker::Name.name }
    sequence(:publisher_name) { Faker::Lorem.word }
    sequence(:published_date)  { |n| n.year.ago.to_date }
    sequence(:unit_price)  { |n| n * 100 }
    sequence(:total_rating_value)  { rand(1..5) }
    sequence(:total_rating_count)  { 3 }
  end
end