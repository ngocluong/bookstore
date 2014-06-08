class StoreController < ApplicationController
  
  def index
    @books = Book.all.page params[:page]
  end
end
