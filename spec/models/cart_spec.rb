require 'spec_helper'

describe Cart do
  let(:cart) { create :cart }
  let(:book) { create :book }

  it { should have_many(:line_items).dependent(:destroy) }

  context '#add_book' do
    context 'book item exists' do
      let!(:line_item) { create :line_item, cart: cart, book: book }
      let(:current_item) { cart.add_book(book.id) }

      it 'increases current item quantity' do
        expect(current_item.quantity).to eq(line_item.quantity + 1)
      end
    end

    context 'current item does not exist' do

      it 'builds new current item' do
        expect(cart.add_book(book.id)).to be_new_record
      end
    end
  end

  context '#total_price' do
    let!(:line_items) { create_list :line_item, 3, cart: cart }

    it 'calculates total price' do
      expect(cart.total_price).to eq(line_items.map(&:total_price).sum)
    end
  end

  context '#total_books' do
    let!(:line_items) { create_list :line_item, 3, cart: cart }

    it 'calculates total books' do
      expect(cart.total_books).to eq(line_items.map(&:quantity).sum)
    end
  end
end
