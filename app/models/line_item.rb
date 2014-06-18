class LineItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :cart
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    book.unit_price * quantity
  end
end
