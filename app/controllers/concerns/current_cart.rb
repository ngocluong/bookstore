module CurrentCart
  extend ActiveSupport::Concern

  private
    def set_cart
      @cart = Cart.find_by_code(session[:cart_code])
      if !@cart.present?
        @cart = Cart.create(code: Devise.friendly_token)
        session[:cart_code] = @cart.code
      end
    end
end
