class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  after_save :update_total_rating

  paginates_per 9
  max_paginates_per 50

  after_update :clear_comment_cache
  after_create :clear_comment_cache

  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :content, presence: true

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
