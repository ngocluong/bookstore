class Comment
  class Cachier
    attr_accessor :book, :page

    def self.fetch_comments(*args)
      new(*args).cache_comment
    end

    def self.clear_cache(*args)
      new(*args).destroy
    end

    def initialize(options = {})
      self.book = options[:book]
      self.page = options[:page]
    end

    def cache_comment
      Rails.cache.fetch(cache_key) do
        add_comment_cache_key
        paginated_comments = book.comments.page(page).includes(:user)
        paginated_info = PaginationInfoBuilder.build_pagination_info(data: paginated_comments)
        {
          paginated_info: paginated_info,
          paginated_data: paginated_comments.to_a
        }
      end
    end

    def destroy
      ClearListCacheWorker.perform_async(comment_list_key) if Rails.cache.read(comment_list_key).present?
    end

    private
    def add_comment_cache_key
      Rails.cache.write(comment_list_key, (comment_cache_keys << cache_key).uniq)
    end

    def comment_cache_keys
      Rails.cache.fetch(comment_list_key) { [] }
    end

    def cache_key
      "comment_#{book.id}_#{page}"
    end

    def comment_list_key
      'comment_cache_list'
    end
  end
end
