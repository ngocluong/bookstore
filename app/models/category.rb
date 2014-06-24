class Category < ActiveRecord::Base
  validates :sort_order, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true

  has_many :category_books, dependent: :destroy
  has_many :books, through: :category_books

  after_update :clear_category_cache
  after_create :clear_category_cache

  private
  def clear_category_cache
    Category::Cachier.new.clear_cache
  end
end
