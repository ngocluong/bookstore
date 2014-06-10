class CategoryBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :category

  validates :book, :category, presence: true
  validates :book_id, uniqueness: { scope: :category_id }
end
