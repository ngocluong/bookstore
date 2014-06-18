require 'spec_helper'

describe OrdersController do
  let(:book) { create :book }
  let(:user) { create :confirm_user}
  let(:cart) { create :cart }
  let!(:line_item) { create :line_item, cart: cart }

  context 'GET new' do
    let(:new_order) { assigns[:order] }

    context 'Get new order successfully' do
      include_context 'login user'

      before do
        session[:cart_code] = line_item.cart.code
        get :new
      end

      it 'renders new order' do
        expect(new_order).to be_a(Order)
        expect(new_order).to be_new_record
      end
    end

    context 'Get new order without login' do
      before do
        session[:cart_code] = line_item.cart.code
        get :new
      end

      it 'redirect to book path with notice' do
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq('You need to sign in inorder to order')
      end
    end

    context 'Get new order with empty line' do
      include_context 'login user'

      before do
        get :new
      end

      it 'redirect to book path with notice' do
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq('Your cart is empty')
      end
    end
  end
end
