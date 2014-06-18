require 'spec_helper'

describe LineItem do
  it { should belong_to :cart }
  it { should belong_to :book }
  it { should belong_to :order }

  context '#total_price' do
    let(:line_item) { create :line_item }

    it 'returns correct total price value' do
      expect(line_item.total_price).to eq line_item.quantity * line_item.book.unit_price
    end
  end
end
