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
      Rails.cache.fetch(cache_key) do
        add_search_cache_key
        paginated_books = query.present? ? Book.search(query) : Book.all
        paginated_books = paginated_books.joins(:categories).where(categories: { id: category_id }) if category_id.present?
        paginated_books = paginated_books.page(page).per(per_page)
        paginated_info = PaginationInfoBuilder.build_pagination_info(data: paginated_books)
        {
          paginated_info: paginated_info,
          paginated_data: paginated_books.to_a
        }
      end
    end

    def clear_search_cache
      ClearListCacheWorker.perform_async(search_list_key) if Rails.cache.read(search_list_key).present?
    end

    def add_search_cache_key
      Rails.cache.write(search_list_key, (search_cache_keys << cache_key).uniq)
    end

    private
    def cache_key
      "search_#{category_id}_#{query}_#{page}_#{per_page}"
    end

    def search_cache_keys
      Rails.cache.fetch(search_list_key) { [] }
    end

    def search_list_key
      'search_cache_list'
    end
  end
end
