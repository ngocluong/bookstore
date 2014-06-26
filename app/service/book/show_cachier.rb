class Book
  class ShowCachier
    attr_accessor :id

    def self.fetch_books(*args)
      new(*args).cache_book
    end

    def self.clear_cache(*arg)
      new(*arg).destroy
    end

    def initialize(options = {})
      self.id = options[:id]
    end

    def cache_book
      Rails.cache.fetch(cache_key) do
        Book.find(id)
      end
    end

    def destroy
      ClearCacheWorker.perform_async(cache_key) unless Rails.cache.read(cache_key).nil?
    end

    private
    def cache_key
      "book_#{id}"
    end
  end
end
