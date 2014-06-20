class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  before_create :set_cart_code

  def add_book(book_id)
    current_line_item = line_items.where(book_id: book_id).first_or_initialize
    current_line_item.increment(:quantity)
    current_line_item
  end

  def total_price
    line_items.joins(:book).sum('books.unit_price * line_items.quantity')
  end

  def total_books
    line_items.sum('line_items.quantity')
  end

  private
  def set_cart_code
    self.code = Devise.friendly_token
  end
end
