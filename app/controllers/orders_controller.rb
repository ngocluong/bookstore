class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :authorize

  def new
    if @cart.line_items.empty?
      redirect_to books_path, notice: 'Your cart is empty'
    end
    @order = Order.new
  end

  private
  def authorize
    unless user_signed_in?
      redirect_to books_path, notice: 'You need to sign in inorder to order'
    end
  end
end
