class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  after_save :update_total_rating

  paginates_per 9
  max_paginates_per 50

  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :content, presence: true

  private
  def update_total_rating
    book = Book.find_by_id(book_id)
    book.total_rating_value += rating
    book.total_rating_count += 1
    book.save
  end
end
