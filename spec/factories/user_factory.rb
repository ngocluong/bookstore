FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Devise.friendly_token }
    full_name { Faker::Name.name }
    phone { "111-111-1111" }
    sequence(:birthday) { |n| n.year.ago.to_date }
    creation_date { Time.now }
  end

  factory :confirm_user, parent: :user do
    after(:create) do |user|
      user.confirm!
    end
  end
end
