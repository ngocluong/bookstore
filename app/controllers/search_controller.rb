class SearchController < ApplicationController
  def index
    @books = BookSearcher.new(params.slice(:q, :category_id, :page, :per_page)).result

    if @books.total_pages == 0
      redirect_to books_path, notice: 'Can not find books which have title or author like this'
    else
      render '/books/index'
    end
  end
end
