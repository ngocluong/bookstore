require 'spec_helper'

describe Category::Cachier do
  let!(:categories) { create_list :category_book, 3 }
  let(:cache_key) { 'categories_cache_key' }

  def get_category_array()
    Category.order(:sort_order).select('id, name').map do |category|
      [category.name, category.id]
    end
  end

  def clear_cache
    ClearCacheWorker.new.perform(cache_key) if Rails.cache.read(cache_key).present?
  end

  def fetch_category
    Category::Cachier.new.fetch_categories
  end

  before do
    Rails.cache.clear
  end

  describe '.fetch_categories' do
    it 'fetches book' do
      expect(fetch_category).to match_array(get_category_array)
    end
  end

  describe '#clear_cache' do
    before do
      fetch_category
      clear_cache
    end

    it 'clears book list key' do
      expect(Rails.cache.fetch(cache_key)).to be_nil
    end
  end
end
