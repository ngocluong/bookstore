class BookSearcher
  attr_accessor :query, :category_id, :page, :per_page

  def initialize(options = {})
    self.category_id = options[:category_id]
    self.query = options[:q]
    self.page = options[:page]
    self.per_page = options[:per_page]
  end

  def result
    Book::SearchCachier.search_books(page: page, per_page: per_page, query: query, category_id: category_id)
  end
end
