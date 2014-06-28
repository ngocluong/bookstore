require 'spec_helper'

describe LineItem do
  it { should belong_to :cart }
  it { should belong_to :book }
  it { should belong_to :order }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }

  context '#total_price' do
    let(:line_item) { create :line_item }

    it 'returns correct total price value' do
      expect(line_item.total_price).to eq line_item.quantity * line_item.book.unit_price
    end
  end
end
