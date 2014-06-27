class OrdersController < ApplicationController
  include CurrentCart
  before_action :authorize
  before_action :set_cart, only: [:new, :create]

  def new
    if @cart.line_items.empty?
      redirect_to books_path, notice: 'Your cart is empty'
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    if @order.save
      Cart.find_by_code(session[:cart_code]).destroy
      session[:cart_code] = nil

      redirect_to books_path, notice: 'Thank you for your order'
    else
      render action: 'new'
    end
  end

  private
  def authorize
    unless user_signed_in?
      redirect_to books_path, notice: 'You need to sign in inorder to check out'
    end
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end