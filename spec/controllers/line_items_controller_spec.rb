require 'spec_helper'

describe LineItemsController do
  let(:book) { create :book }
  let(:cart) { create :cart }
  let!(:line_item) { create :line_item, cart: cart }

  def create_line_item
    post :create, book_id: book_id
  end

  def update_line_item
    put :update, { id: line_item.id, line_item: line_item_attributes}
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

      it 'raises record not found error' do
        expect do
          create_line_item
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'PUT update' do
    context 'updates with valid value' do
      let(:quantity) { 5 }
      let(:line_item_attributes) { { quantity: quantity } }

      before do
        update_line_item
      end

      it 'changes the quantity of this product' do
        expect(line_item.reload.quantity).to eq quantity
      end

      it 'redirects to cart page show successful notice' do
        expect(response).to redirect_to(cart_path(line_item.cart))
        expect(flash[:notice]).to eq('Update successfully')
      end
    end

    context 'update with invalid value' do
      let(:quantity) { 'vv' }
      let(:line_item_attributes) { { quantity: quantity } }

      it 'keeps old value' do
        expect do
          update_line_item
        end.not_to change { line_item.reload.attributes }
      end
    end
  end
end
