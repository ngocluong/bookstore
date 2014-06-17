class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:update, :destroy]

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_book(book.id)

    if @line_item.save
      redirect_to books_path, notice: 'Add book to cart successfully'
    else
      redirect_to books_path, notice: @line_item.errors.full_messages.to_sentence
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to cart_path(@line_item.cart), notice: 'Update successfully'
    else
      redirect_to cart_path(@line_item.cart), notice: @line_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    @line_item.destroy
    redirect_to cart_path(@line_item.cart), notice: 'Remove successfully'
  end
  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:quantity)
    end
end
