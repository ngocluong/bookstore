require 'spec_helper'

describe SearchController do

  context 'GET new' do
    let (:books) { create_list :book, 2 }
    let (:categories) { create_list :category, 2 }

    before do
      books.each do |book|
          categories.first.books << book
      end
    end

    context 'Search result have some books' do
      before do
        get :index, { q: books.first.title, category_id: categories.first.id }
      end

      it 'render first book' do
        expect(assigns[:books]).to include(books.first)
        expect(assigns[:books]).not_to include(books.last)
      end
    end

    context 'search get no result' do
      def search
        get :index, { q: books.first.title, category_id: categories.last.id }
      end

      context 'Search with invalid book title' do
        it 'notice and render all books' do
          expect(search).to redirect_to('/books')
          expect(flash[:notice]).to eq('Can not find books which have title or author like this')
        end
      end
    end
  end
end
