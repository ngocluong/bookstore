class Category < ActiveRecord::Base
  validates :sort_order, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true

  has_many :category_books
  has_many :books, through: :category_books
end
