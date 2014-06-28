require 'spec_helper'

describe Comment::Cachier do
  let!(:book) { create :book }
  let(:cache_key) { "comment_#{book.id}_" }
  let(:per_page) { Book.default_per_page }
  let(:comment) { create_list :comment, 3, book: book }
  let(:comment_cachier) { Comment::Cachier.new(book: book) }
  let!(:comment_list_key) { 'comment_cache_list' }

  def paginated_comments_array(options = {})
    Kaminari.paginate_array(book.comments).page(options.fetch(:page, 0)).per(options.fetch(:per_page, per_page))
  end

  def clear_cache
    ClearListCacheWorker.new.perform(comment_list_key) if Rails.cache.read(comment_list_key).present?
  end

  def fetch_comment
    Comment::Cachier.fetch_comments(book: book)
  end

  before do
    Rails.cache.clear
  end

  describe '.fetch_comments' do
    it 'fetches paginated comment data' do
      expect(fetch_comment[:paginated_data]).to match_array(paginated_comments_array)
    end

    it 'fetches paginated info' do
      expect(fetch_comment[:paginated_info]).to eq(PaginationInfoBuilder.build_pagination_info(data: paginated_comments_array))
    end
  end

  describe '#clear_cache' do
    before do
      fetch_comment
      clear_cache
    end

    it 'clears book list key' do
      expect(Rails.cache.fetch(comment_list_key)).to be_nil
    end
  end

  describe '#add_comment_cache_key' do
    before do
      comment_cachier.add_comment_cache_key
    end

    it 'adds record to Rails cache' do
      expect(Rails.cache.read(comment_list_key)).to include(cache_key)
    end
  end
end
