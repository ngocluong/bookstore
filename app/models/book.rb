class Book < ActiveRecord::Base
  paginates_per 10
  max_paginates_per 50
  validates :title, :description, :image_url, :unit_price, :published_date, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png|jpeg)\Z}i,
    message: 'must be a URL for GIF, JPG, JPEG or PNG image'
  }

  PAGINATION_OPTIONS = [10, 15 , 20, 25]
end
