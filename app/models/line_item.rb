class LineItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :cart

  def total_price
    book.unit_price * quantity
  end
end
