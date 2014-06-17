require 'spec_helper'

describe SearchController do

  context 'GET new' do
    let (:books) { create_list :book, 2 }
    let (:categories) { create_list :category, 2 }
    let (:first_book_title) { books.first.title }

    before do
      books.each do |book|
          categories.first.books << book
      end
    end

    context 'Search result have some books' do
      before do
        let (:first_category_id) { categories.first.id }
        get :index, { q: first_book_title, category_id: first_category_id }
      end

      it 'renders first book' do
        expect(assigns[:books]).to include(books.first)
        expect(assigns[:books]).not_to include(books.last)
      end
    end

    context 'search get no result' do
      def search
        let (:last_category_id) { categories.last.id }
        get :index, { q: first_book_title, category_id: last_category_id }
      end

      context 'Search with invalid book title' do
        it 'notice and render all books' do
          expect(search).to redirect_to(books_path)
          expect(flash[:notice]).to eq('Can not find books which have title or author like this')
        end
      end
    end
  end
end
