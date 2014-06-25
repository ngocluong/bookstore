class Book
  class SearchCachier
    attr_accessor :page, :per_page, :query, :category_id

    def self.search_books(*args)
      new(*args).cache_search_book
    end

    def initialize(options = {})
      self.page = options[:page]
      self.per_page = options[:per_page]
      self.query = options[:query]
      self.category_id = options[:category_id]
    end

    def cache_search_book
      add_search_cache_key
      Rails.cache.fetch(cache_key) do
        paginated_books = Book.search(query)
        paginated_books = paginated_books.joins(:categories).where(categories: { id: category_id }) if category_id.present?
        paginated_books = paginated_books.page(page).per(per_page)
        paginated_info =  OpenStruct.new(current_page: paginated_books.current_page, total_pages: paginated_books.total_pages, per_page: paginated_books.limit_value)
        {
          paginated_info: paginated_info,
          paginated_data: paginated_books.to_a
        }
      end
    end

    def clear_search_cache
      if Rails.cache.read(search_list_key).present?
        Rails.cache.read(search_list_key).each do |search_key|
          Rails.cache.delete(search_key)
        end
        Rails.cache.delete(search_list_key)
      end
    end

    def add_search_cache_key
      Rails.cache.write(search_list_key, (search_cache_keys << cache_key).uniq)
    end

    private
    def cache_key
      "search_#{category_id}_#{query}"
    end

    def search_cache_keys
      Rails.cache.fetch(search_list_key) { [] }
    end

    def search_list_key
      'search_cache_list'
    end
  end
end
