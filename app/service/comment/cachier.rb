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
        paginated_comments = book.comments.page(page).includes(:user)
        paginated_info =  OpenStruct.new(current_page: paginated_comments.current_page, total_pages: paginated_comments.total_pages, per_page: paginated_comments.limit_value)
        {
          paginated_info: paginated_info,
          paginated_data: paginated_comments.to_a
        }
      end
    end

    def destroy
      Rails.cache.delete(cache_key) if Rails.cache.read(cache_key).present?
    end

    private
    def cache_key
      "comment_#{book.id}_#{page}"
    end
  end
end
