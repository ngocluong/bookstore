class BooksController < ApplicationController

  def index
    @books = Book.all.page(params[:page]).per(params[:per_page])
  end
end
