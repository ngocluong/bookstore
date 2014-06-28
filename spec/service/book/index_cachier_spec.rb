require 'spec_helper'

describe Book::IndexCachier do
  let!(:books) { create_list :book, per_page + 1 }
  let(:per_page) { Book.default_per_page }
  let(:cache_key) { "book__#{per_page}" }
  let(:index_cachier) { Book::IndexCachier.new(per_page: per_page) }
  let!(:book_list_key) { 'books_cache_list' }

  def paginated_books_array(options = {})
    Kaminari.paginate_array(books).page(options.fetch(:page, 0)).per(options.fetch(:per_page, per_page))
  end

  def clear_cache
    ClearListCacheWorker.new.perform(book_list_key) if Rails.cache.read(book_list_key).present?
  end

  def fetch_book
    Book::IndexCachier.fetch_books
  end

  before do
    Rails.cache.clear
  end

  describe '.fetch_books' do
    it 'fetches paginated data' do
      expect(fetch_book[:paginated_data]).to match_array(paginated_books_array)
    end

    it 'fetches paginated info' do
      expect(fetch_book[:paginated_info]).to eq(PaginationInfoBuilder.build_pagination_info(data: paginated_books_array))
    end
  end

  describe '#clear_cache' do
    before do
      fetch_book
      clear_cache
    end

    it 'clears book list key' do
      expect(Rails.cache.fetch(book_list_key)).to be_nil
    end
  end

  describe '#add_book_cache_key' do
    before do
      index_cachier.add_book_cache_key
    end

    it 'adds record to Rails cache' do
      expect(Rails.cache.read(book_list_key)).to include(cache_key)
    end
  end
end
