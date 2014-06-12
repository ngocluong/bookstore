require 'spec_helper'

describe BookSearcher do
  let (:books) { create_list :book, 2 }
  let (:categories) { create_list :category, 2 }

  before do
    books.each do |book|
        categories.first.books << book
    end
  end

  context 'Book Searcher return some book' do
    context 'Search books with valid books title' do
      it 'return first book' do
        expect(BookSearcher.new(q: books.first.title).result).to include(books.first)
      end
    end

    context 'Search books with valid author' do
      it 'return first book' do
        expect(BookSearcher.new(q: books.first.author_name).result).to include(books.first)
      end
    end

    context 'Search with category in addition' do
      it 'return first book' do
        expect(BookSearcher.new(q: books.first.author_name, category_id: categories.first.id).result).to include(books.first)
      end
    end
  end

  context 'Book searcher return empty' do
    context 'Search with invalid book title' do
      it 'return empty' do
        expect(BookSearcher.new(q: 'something else').result).to be_empty
      end
    end

    context 'Search with available title but not contain in category' do
      it 'return empty' do
        expect(BookSearcher.new(q: books.first.title, category_id: categories.last.id).result).to be_empty
      end
    end
  end
end
