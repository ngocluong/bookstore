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
        paginated_info =  OpenStruct.new(current_page: paginated_comments.current_page, total_pages: paginated_comments.total_pages, per_page: paginated_comments.limit_value)
        {
          paginated_info: paginated_info,
          paginated_data: paginated_comments.to_a
        }
      end
    end

    def destroy
      if Rails.cache.read(comment_list_key).present?
        Rails.cache.read(comment_list_key).each do |comment_key|
          Rails.cache.delete(comment_key) if comment_key.start_with?("comment_#{book.id}")
        end
        Rails.cache.write(comment_list_key, delete_comment_cache_keys)
      end
    end

    private
    def add_comment_cache_key
      Rails.cache.write(comment_list_key, (comment_cache_keys << cache_key).uniq)
    end

    def delete_comment_cache_keys
      Rails.cache.read(comment_list_key).delete_if do |comment_key|
        comment_key.start_with?("comment_#{book.id}") ? true : false
      end
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
