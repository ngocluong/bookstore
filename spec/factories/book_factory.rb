FactoryGirl.define do
  factory :book do
    sequence (:title) { |n| "#{n} #{Faker::Name.name}" }
    description { Faker::Lorem.sentence }
    image_url "default.png"
    author_name { Faker::Name.name }
    sequence(:publisher_name) { Faker::Lorem.word }
    sequence(:published_date)  { |n| n.year.ago.to_date }
    sequence(:unit_price)  { |n| n * 100 }
    total_rating_value { rand(1..5) }
    total_rating_count  { rand(1..5) }
  end
end
