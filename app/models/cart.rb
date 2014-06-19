class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_book(book_id)
    current_line_item = line_items.where(book_id: book_id).first_or_initialize
    current_line_item.increment(:quantity)
    current_line_item
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

  def total_books
    line_items.to_a.sum {|item| item.quantity}
  end
end
