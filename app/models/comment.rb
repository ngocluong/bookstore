class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  # after_save :update_rating_average

  validates :rating, numericality: { greater_than_or_equal_to: 0 }
  validates :content, presence: true

  private
  def update_rating_average
    product = Product.find(user_id)
    product.total_rating_value = (rating + product.total_rating_value) / (total_rating_count + 1)
  end
end
