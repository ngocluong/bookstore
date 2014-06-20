class Order
  class Calculator
    attr_accessor :line_items

    def initialize(options = {})
      self.line_items = options[:line_items]
    end

    def total_price
      line_items.joins(:book).sum('books.unit_price * line_items.quantity')
    end

    def total_books
      line_items.sum('line_items.quantity')
    end
  end
end
