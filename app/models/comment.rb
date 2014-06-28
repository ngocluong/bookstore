class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  paginates_per 9
  max_paginates_per 50

  after_create :update_total_rating, :clear_comment_cache

  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :content, :user, :book, presence: true

  private
  def update_total_rating
    book.total_rating_value += rating
    book.increment(:total_rating_count)
    book.save
  end

  def clear_comment_cache
    Comment::Cachier.clear_cache(book: book)
  end
end
