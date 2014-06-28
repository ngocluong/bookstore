class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  before_create :set_cart_code

  def add_book(book_id)
    current_line_item = line_items.where(book_id: book_id).first_or_initialize
    current_line_item.increment(:quantity)
    current_line_item
  end

  def total_price
    calculator.total_price
  end

  def total_books
    calculator.total_books
  end

  private
  def calculator
    @calculator ||= Order::Calculator.new(line_items: line_items)
  end

  def set_cart_code
    self.code = Devise.friendly_token
  end
end
