FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Devise.friendly_token }
    full_name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    sequence(:birthday) { |n| n.year.ago }
  end
end
