class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def index
    @books_data = Book::IndexCachier.fetch_books(page: params[:page], per_page: params[:per_page])
  end

  def show
    @comments = Comment::Cachier.fetch_comments(page: params[:page], book: @book)
  end

  private
  def set_book
    @book = Book::ShowCachier.fetch_books(id: params[:id])
  end
end
