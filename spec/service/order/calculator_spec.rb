require 'spec_helper'

describe Order::Calculator do
  let!(:line_items) { create_list :line_item, 3 }
  let(:calculator) { Order::Calculator.new(line_items: LineItem.all) }

  context 'calculator return total price' do

    it 'calculates total price' do
      expect(calculator.total_price).to eq(line_items.sum(&:total_price))
    end
  end

  context 'calculator return total books' do

    it 'calculates total books' do
      expect(calculator.total_books).to eq(line_items.sum(&:quantity))
    end
  end
end
