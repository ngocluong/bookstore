require 'spec_helper'

describe Category do
  it { should validate_numericality_of(:sort_order).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:name) }
  it { should have_many(:category_books).dependent(:destroy) }
  it { should have_many(:books).through(:category_books) }
end
