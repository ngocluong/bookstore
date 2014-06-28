class ClearCacheWorker
  include Sidekiq::Worker

  def perform(cache_key)
    Rails.cache.delete(cache_key)
  end
end
