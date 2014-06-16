class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_book(book.id)

    if @line_item.save
      redirect_to books_path, notice: 'Add book to cart successfully'
    else
      redirect_to books_path, notice: @line_item.errors.full_messages.to_sentence
    end
  end
end
