require 'spec_helper'

describe Order do
  [:name, :address, :email].each do |attr|
    it { should validate_presence_of attr }
  end
  it { should have_many(:line_items).dependent(:destroy) }

  context '#add_line_items_from_cart' do
    let(:order) { create :order }
    let(:cart) { create :cart }
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
end
