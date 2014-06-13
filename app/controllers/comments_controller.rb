class CommentsController < ApplicationController
  layout false
  before_action :authorize

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params.merge(rating: params[:rating], user_id: current_user.id))
    @book_id = params[:book_id]
    if @comment.save
      redirect_to(book_path(notice: 'Thank you for your contribution', id: @book_id))
    else
      render action: 'new'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:rating, :content ,:book_id, :user_id)
    end

    def authorize
      unless user_signed_in?
        render text: 'You need to sign in inorder to make new comment'
      end
    end
end
