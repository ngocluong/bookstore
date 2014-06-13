class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :book
  validates :rating, numericality: { greater_than_or_equal_to: 0 }
  validates :content, presence: true
end
