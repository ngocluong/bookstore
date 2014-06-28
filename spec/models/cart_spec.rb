require 'spec_helper'

describe Cart do
  let(:cart) { create :cart }
  let(:book) { create :book }
  let(:calculator) { Order::Calculator.new(line_items: LineItem.all) }

  it { should have_many(:line_items).dependent(:destroy) }

  context '#add_book' do
    let(:current_item) { cart.add_book(book.id) }

    context 'book item exists' do
      let!(:line_item) { create :line_item, cart: cart, book: book }

      it 'increases current item quantity' do
        expect(current_item.quantity).to eq(line_item.quantity + 1)
      end
    end

    context 'current item does not exist' do

      it 'builds new current item' do
        expect(current_item).to be_new_record
      end
    end
  end

  context '#total_price' do
    let!(:line_item) { create :line_item, cart: cart, book: book }

    it 'calculates total price' do
      expect(cart.total_price).to eq(calculator.total_price)
    end
  end

  context '#total_books' do

    it 'calculates total books' do
      expect(cart.total_books).to eq(calculator.total_books)
    end
  end
end
