class Book
  class IndexCachier
    attr_accessor :page, :per_page

    def self.fetch_books(*args)
      new(*args).cache_book
    end

    def initialize(options = {})
      self.page = options[:page]
      self.per_page = options[:per_page]
    end

    def cache_book
      Rails.cache.fetch(cache_key) do
        add_book_cache_key
        paginated_books = Book.page(page).per(per_page)
        paginated_info =  OpenStruct.new(current_page: paginated_books.current_page, total_pages: paginated_books.total_pages, per_page: paginated_books.limit_value)
        {
          paginated_info: paginated_info,
          paginated_data: paginated_books.to_a
        }
      end
    end

    def clear_cache
      ClearListCacheWorker.perform_async(book_list_key) if Rails.cache.read(book_list_key).present?
    end

    def add_book_cache_key
      Rails.cache.write(book_list_key, (book_cache_keys << cache_key).uniq)
    end

    private
    def cache_key
      "book_#{page}_#{per_page}"
    end

    def book_cache_keys
      Rails.cache.fetch(book_list_key) { [] }
    end

    def book_list_key
      'books_cache_list'
    end
  end
end
