# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    book
    cart nil
    quantity { rand(1..5) }
  end
end
