class Book < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: [:title, :author_name]

  has_many :line_items
  has_many :comments, -> { order(id: :desc) }, dependent: :destroy
  has_many :category_books, dependent: :destroy
  has_many :categories, through: :category_books

  paginates_per 9
  max_paginates_per 50
  PAGINATION_OPTIONS = [9, 12 , 15, 18]

  validates :title, :description, :image_url, :unit_price, :published_date, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png|jpeg)\Z}i,
    message: 'must be a URL for GIF, JPG, JPEG or PNG image'
  }
end
