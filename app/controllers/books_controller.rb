class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def index
    @books = Book.page(params[:page]).per(params[:per_page])
  end

  def show
    @comments = @book.comments.page(params[:page]).per(params[:per_page]).includes(:user)
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end
end
