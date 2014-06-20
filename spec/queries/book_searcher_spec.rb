require 'spec_helper'

describe BookSearcher do
  def book_searcher_init(options = {})
    BookSearcher.new(options.slice(:q, :category_id, :page, :per_page))
  end

  let (:books) { create_list :book, 2 }
  let (:categories) { create_list :category, 2 }
  let (:first_book_title) { books.first.title }
  let (:first_book_author) { books.first.author_name }
  let (:first_category_id) { categories.first.id }

  before do
    books.each do |book|
      categories.first.books << book
    end
  end

  context 'Book Searcher return some book' do
    context 'Search books with valid books title' do

      it 'return first book' do
        expect(book_searcher_init(q: first_book_title).result).to include(books.first)
      end
    end

    context 'Search books with valid author' do

      it 'return first book' do
        expect(book_searcher_init(q: first_book_author).result).to include(books.first)
      end
    end

    context 'Search with category in addition' do

      it 'return first book' do
        expect(book_searcher_init(q: first_book_author, category_id: first_category_id).result).to include(books.first)
      end
    end
  end

  context 'Book searcher return empty' do
    context 'Search with invalid book title' do
      let (:query) { 'something else'}

      it 'returns empty' do
        expect(book_searcher_init(q: query).result).to be_empty
      end
    end

    context 'Search with available title but not contain in category' do
      let (:last_category_id) { categories.last.id }

      it 'returns empty' do
        expect(book_searcher_init(q: first_book_title, category_id: last_category_id).result).to be_empty
      end
    end
  end
end
