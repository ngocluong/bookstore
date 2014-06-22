class CommentsController < ApplicationController
  layout false
  before_action :authorize
  before_action :normalize_params, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      notice = 'Thank you for your contribution'
    else
      notice = @comment.errors.full_messages.to_sentence
    end
    redirect_to book_path(@comment.book), notice: notice
  end

  private
  def comment_params
    params.require(:comment).permit(:content ,:book_id, :user_id, :rating)
  end

  def authorize
    unless user_signed_in?
      render text: 'You need to sign in inorder to make new comment'
    end
  end

  def normalize_params
    params[:comment][:rating] ||= params.delete(:score)
    params[:comment][:user_id] = current_user.id
  end
end
