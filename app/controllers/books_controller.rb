class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def index
    @books_data = Book::IndexCachier.fetch_books(page: params[:page], per_page: params[:per_page])
  end

  def show
    @comments = @book.comments.page(params[:page]).per(params[:per_page]).includes(:user)
  end

  private
  def set_book
    @book = Book::ShowCachier.fetch_books(id: params[:id])
  end
end
