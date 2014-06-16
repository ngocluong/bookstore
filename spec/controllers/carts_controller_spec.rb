require 'spec_helper'

describe CartsController do
  let(:cart) { create :cart }
  let(:line_item) { create :line_item, cart: cart }
  context 'GET show' do
    context 'Show valid cart' do
      before do
        session[:cart_id] = cart.id
        get :show, id: cart.id
      end

      it 'return cart' do
        expect(assigns[:cart]).to eq cart
      end
    end

    context 'shows invalid cart' do
      before do
        get :show, id: cart.id
      end

      it 'shows invalid notice' do
        expect(flash[:notice]).to eq('Invalid cart')
      end
    end
  end
end
