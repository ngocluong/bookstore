class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :validate_cart_session, only: [:destroy]
  before_action :set_line_item, only: [:update, :destroy]

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_book(book.id)

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
    cart = Cart.find_by_code(session[:cart_code])
    cart.line_items.where(line_items: {id: params[:id]}).destroy_all
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
end
