class CartsController < ApplicationController
  before_action :validate_cart_id, :set_cart, only: [:show]

  def show
    @line_items = @cart.line_items.includes(:book)
  end

  private
  def set_cart
    @cart = Cart.find_by_code(params[:id])
  end

  def validate_cart_id
    if params[:id] != session[:cart_code]
      redirect_to books_path, notice: 'Invalid cart'
    end
  end
end
