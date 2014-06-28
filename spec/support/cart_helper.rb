shared_context 'has_cart' do
  before do
    session[:cart_code] = line_item.cart.code
  end
end
