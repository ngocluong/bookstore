class Category
  class Cachier
    def fetch_categories
      Rails.cache.fetch(cache_key) do
        Category.order(:sort_order).select('id, name').map do |category|
          [category.name, category.id]
        end
      end
    end

    def clear_cache
      Rails.cache.delete(cache_key)
    end

    private
    def cache_key
      'categories_cache_key'
    end
  end
end
