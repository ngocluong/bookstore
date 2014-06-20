class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, :validate_book_id,  only: [:create]
  before_action :validate_cart_session, only: [:destroy]
  before_action :set_line_item, only: [:update, :destroy]

  def create
    @line_item = @cart.add_book(params[:book_id])

    if @line_item.save
      flash[:notice] = 'Add book to cart successfully'
    else
      flash[:error] = @line_item.errors.full_messages.to_sentence
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to cart_path(@line_item.cart.code), notice: 'Update successfully'
    else
      redirect_to cart_path(@line_item.cart.code), notice: @line_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    LineItem.includes(:cart).where(carts: { code: session[:cart_code] }, line_items: { id: params[:id] }).destroy_all
    redirect_to cart_path(@line_item.cart.code), notice: 'Remove successfully'
  end

  private
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end

  def validate_cart_session
    if !session[:cart_code].present?
      redirect_to books_path, notice: 'Cart is not present'
    end
  end

  def validate_book_id
    if !Book.exists?(params[:book_id])
      redirect_to books_path, notice: 'Invalid book'
    end
  end
end
