class SearchController < ApplicationController

  def new
    if params[:search].blank?
      @books = Book.all
    else
      @books = Book.search(params[:search])
    end

    if !params[:category].blank?
      @category = Category.find_by_id(params[:category])
      @books = @books.joins(:categories).where('categories.id = ?', @category)
    end

    if @books.count == 0
      redirect_to(books_path, notice: 'Can not find books which have title or author like this') 
    else
      @books = @books.page(params[:page]).per(params[:per_page])
      render '/books/index'
    end
  end
end
