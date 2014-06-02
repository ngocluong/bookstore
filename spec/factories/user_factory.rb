FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Devise.friendly_token }
    full_name { Faker::Name.name }
    sequence(:phone) { |n| "#{n}#{n}#{n}-#{n}#{n}#{n}-#{n}#{n}#{n}#{n}" }
    sequence(:birthday) { |n| n.year.ago.to_date }
    creation_date { Time.now }
  end

  factory :confirm_user, parent: :user do
    after(:create) do |user|
      user.confirm!
    end
  end
end
