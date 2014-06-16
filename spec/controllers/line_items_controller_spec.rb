require 'spec_helper'

describe LineItemsController do
  let(:book) { create :book }
  let(:line_item_attributes) { attributes_for :line_item_with_quantity, book: book.id }

  def create_line_item
    post :create, book_id: book_id
  end

  context 'POST create' do
    context 'creates new line item successfully' do
      let(:book_id) { book.id }
      let(:new_line_item) { LineItem.last }

      before do
        create_line_item
      end

      it 'creates cart session' do
        expect(session[:cart_id]).to eq new_line_item.cart_id
      end

      it 'creates new line with correct attributes' do
        expect(new_line_item.book_id).to eq book.id
      end

      it 'shows message successfully' do
        expect(flash[:notice]).to eq('Add book to cart successfully')
      end
    end

    context 'creates new line item with invalid book id' do
      let(:book_id) { -1 }

      it 'it raises record not found error' do
        expect do
          create_line_item
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
