require 'spec_helper'

describe OrdersController do
  let(:book) { create :book }
  let(:user) { create :confirm_user}
  let(:cart) { create :cart }
  let!(:line_item) { create :line_item, cart: cart }

  def create_order
    post :create, order: order_attributes
  end

  context 'GET index' do
    context 'load all post orders belong to user' do
      include_context 'login user'
      let(:order) { create :order, user: user}

      before do
        get :index
      end

      it 'renders all order belong to current user' do
        expect(assigns[:orders]).to include(order)
      end
    end
  end

  context 'GET new' do
    let(:new_order) { assigns[:order] }

    context 'Get new order successfully' do
      include_context 'has_cart'
      include_context 'login user'

      before do
        get :new
      end

      it 'renders new order' do
        expect(new_order).to be_a(Order)
        expect(new_order).to be_new_record
      end
    end

    context 'Get new order without login' do
      include_context 'has_cart'

      before do
        get :new
      end

      it 'redirects to book path with notice' do
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq('You need to sign in')
      end
    end

    context 'Get new order with empty line' do
      include_context 'login user'

      before do
        get :new
      end

      it 'redirects to book path with notice' do
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq('Your cart is empty')
      end
    end
  end

  context 'POST create' do
    include_context 'has_cart'

    context 'create order successfully' do
      include_context 'login user'

      let(:order_attributes) { attributes_for :order }
      let(:new_order) { Order.last }

      before do
        create_order
      end

      it 'creates order' do
        order_attributes.each do |key, value|
          expect(new_order.send(key)).to eq value
        end
        expect(new_order.user_id).to eq user.id
      end

      it 'destroys this cart' do
        expect(Cart).not_to exist(id: cart.id)
      end

      it 'sets cart session to nil' do
        expect(session[:cart_code]).to be_nil
      end

      it 'redirects to book path with successful notice' do
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq('Thank you for your order')
      end
    end

    context 'create order unsuccessfully' do
      include_context 'login user'

      let(:order_attributes) { { something: 'something'} }

      it 'fails to create new order' do
        expect do
          create_order
        end.not_to change { Order.count }
      end
    end

    context 'create order without sign in' do
      let(:order_attributes) { attributes_for :order }

      before do
        create_order
      end

      it 'redirects to book path with notice' do
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq('You need to sign in')
      end
    end
  end
end
