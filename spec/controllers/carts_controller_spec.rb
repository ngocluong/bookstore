require 'spec_helper'

describe CartsController do
  let(:cart) { create :cart }
  let(:line_item) { create :line_item, cart: cart }

  context 'GET show' do
    context 'valid cart' do
      before do
        session[:cart_code] = cart.code
        get :show, id: cart.code
      end

      it 'returns cart' do
        expect(assigns[:cart]).to eq cart
      end
    end

    context 'invalid cart' do
      before do
        get :show, id: 'invalid'
      end

      it 'shows invalid notice' do
        expect(flash[:notice]).to eq('Invalid cart')
      end
    end
  end
end
