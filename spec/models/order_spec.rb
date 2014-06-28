require 'spec_helper'

describe Order do
  let(:calculator) { Order::Calculator.new(line_items: LineItem.all) }
  let(:order) { create :order }
  let(:cart) { create :cart }

  [:name, :address, :email].each do |attr|
    it { should validate_presence_of attr }
  end
  it { should belong_to(:user) }
  it { should have_many(:line_items).dependent(:destroy) }


  context '#add_line_items_from_cart' do
    let!(:line_items) { create_list :line_item, 2, cart: cart }

    before do
      order.add_line_items_from_cart(cart)
    end

    it 'adds line items to order and removes to cart' do
      line_items.each do |item|
        expect(item.reload.cart_id).to be_nil
        expect(order.line_items.reload).to include(item)
      end
    end
  end

  context '#total_price' do
    let!(:line_items) { create_list :line_item, 3, order: order }

    it 'calculates total price' do
      expect(order.total_price).to eq(calculator.total_price)
    end
  end

  context '#total_books' do
    let!(:line_items) { create_list :line_item, 3, order: order }

    it 'calculates total books' do
      expect(order.total_books).to eq(calculator.total_books)
    end
  end
end
