class BooksController < ApplicationController

  def index
    @categories = Category.all
    @books = Book.page(params[:page]).per(params[:per_page])
  end
end
