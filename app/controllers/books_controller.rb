class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def index
    @books = Book.page(params[:page]).per(params[:per_page])
  end

  def show
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end
end
