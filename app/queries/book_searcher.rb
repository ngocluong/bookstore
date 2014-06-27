class BookSearcher
  attr_accessor :query, :category_id, :page, :per_page

  def initialize(options = {})
    self.category_id = options[:category_id]
    self.query = options[:q]
    self.page = options[:page]
    self.per_page = options[:per_page]
  end

  def result
    books = Book.search(query)
    books = books.joins(:categories).where(categories: { id: category_id }) if category_id.present?
    books.page(page).per(per_page)
  end
end
