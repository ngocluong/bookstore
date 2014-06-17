class SearchController < ApplicationController
  before_filter :validate_query, only: [:index]

  def index
    @books = BookSearcher.new(params.slice(:q, :category_id, :page, :per_page)).result

    if @books.total_pages == 0
      redirect_to books_path, notice: 'Can not find books which have title or author like this'
    else
      render '/books/index'
    end
  end

  private
  def validate_query
    if params[:category_id].blank? && params[:q].blank?
      redirect_to books_path(per_page: params[:per_page])
    end
  end
end
