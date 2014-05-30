FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Devise.friendly_token }
    full_name { Faker::Name.name }
    sequence(:phone) { |n| "#{n}#{n}#{n}-#{n}#{n}#{n}-#{n}#{n}#{n}#{n}" }
    sequence(:birthday) { |n| n.year.ago.to_date }
  end
end
