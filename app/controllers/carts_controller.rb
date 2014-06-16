class CartsController < ApplicationController
  before_action :validate_cart_id, :set_cart, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def validate_cart_id
      if params[:id].to_i != session[:cart_id]
        redirect_to books_path, notice: 'Invalid cart'
      end
    end

    def invalid_cart
      redirect_to books_path, notice: 'Invalid cart'
    end
end
