# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    book
    cart nil
  end

  factory :line_item_with_quantity, parent: :line_item do
    after(:create) do |line_item|
      line_item.update_column :quantity, rand(1..5)
    end
  end
end
