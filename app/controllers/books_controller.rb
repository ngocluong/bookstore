class BooksController < ApplicationController

  def index
    @books = Book.page(params[:page]).per(params[:per_page])
  end
end
