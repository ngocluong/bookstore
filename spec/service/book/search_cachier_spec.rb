require 'spec_helper'

describe Book::SearchCachier do
  let!(:books) { create_list :book, per_page + 1 }
  let(:per_page) { Book.default_per_page }
  let(:category_id) { nil }
  let(:query) { books.first.title }
  let(:cache_key) { "search_#{category_id}_#{query}__#{per_page}" }
  let(:search_cachier) { Book::SearchCachier.new(query: query, per_page: per_page) }
  let!(:search_list_key) { 'search_cache_list' }

  def paginated_search_array(options = {})
    paginated_books = query.present? ? Book.search(query) : Book.all
    paginated_books = paginated_books.joins(:categories).where(categories: { id: category_id }) if category_id.present?
    Kaminari.paginate_array(paginated_books).page(options.fetch(:page, 0)).per(options.fetch(:per_page, per_page))
  end

  def clear_cache
    ClearListCacheWorker.new.perform(search_list_key) if Rails.cache.read(search_list_key).present?
  end

  def seach_books
    Book::SearchCachier.search_books(query: query, per_page: per_page)
  end

  before do
    Rails.cache.clear
  end

  describe '.search_books' do
    it 'fetches paginated search data' do
      expect(seach_books[:paginated_data]).to match_array(paginated_search_array)
    end

    it 'fetches paginated search info' do
      expect(seach_books[:paginated_info]).to eq(PaginationInfoBuilder.build_pagination_info(data: paginated_search_array))
    end
  end

  describe '#clear_search_cache' do
    before do
      seach_books
      clear_cache
    end

    it 'clears search list key' do
      expect(Rails.cache.fetch(search_list_key)).to be_nil
    end
  end

  describe '#add_search_cache_key' do
    before do
      search_cachier.add_search_cache_key
    end

    it 'adds record to Rails cache' do
      expect(Rails.cache.read(search_list_key)).to include(cache_key)
    end
  end
end
