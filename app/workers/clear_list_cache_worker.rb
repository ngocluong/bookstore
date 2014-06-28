class ClearListCacheWorker
  include Sidekiq::Worker

  def perform(list_key)
    Rails.cache.read(list_key).each do |key|
      Rails.cache.delete(key)
    end
    Rails.cache.delete(list_key)
  end
end
