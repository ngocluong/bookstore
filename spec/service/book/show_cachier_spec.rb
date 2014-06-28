require 'spec_helper'

describe Book::ShowCachier do
  let!(:book) { create :book }
  let(:book_id) { book.id }
  let(:cache_key) { "book__#{book_id}" }

  def clear_cache
    ClearCacheWorker.new.perform(cache_key) if Rails.cache.read(cache_key).present?
  end

  def fetch_book
    Book::ShowCachier.fetch_books(id: book_id)
  end

  before do
    Rails.cache.clear
  end

  describe '.fetch_books' do
    it 'fetches book' do
      expect(fetch_book).to eq book
    end
  end

  describe '#clear_cache' do
    before do
      fetch_book
      clear_cache
    end

    it 'clears book list key' do
      expect(Rails.cache.fetch(cache_key)).to be_nil
    end
  end
end
