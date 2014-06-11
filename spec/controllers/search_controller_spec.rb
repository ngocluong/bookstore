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

    context 'Search successfully' do
      context 'Search books with valid books title' do
        before do
          get :new, { search: books.first.title }
        end

        it 'render first book' do
          expect(assigns[:books]).to include(books.first)
          expect(assigns[:books]).not_to include(books.last)
        end
      end

      context 'Search books with valid books author' do
        before do
          get :new, { search: books.first.author_name }
        end

        it 'render first book' do
          expect(assigns[:books]).to include(books.first)
          expect(assigns[:books]).not_to include(books.last)
        end
      end

      context 'Search with category in addition' do
        before do 
          get :new, { search: books.first.title, category: categories.first.id }
        end

        it 'render first book' do
          expect(assigns[:books]).to include(books.first)
          expect(assigns[:books]).not_to include(books.last)
        end
      end
    end

    context 'Search unsuccessfully' do
      
      def search 
        get :new, { search: books.first.title, category: categories.last.id }
      end

      context 'Search with invalid book title' do
        it 'notice and render all books' do
          expect(search).to redirect_to('/books')
          expect(flash[:notice]).to eq('Can not find books which have title or author like this')
        end
      end

      context 'Search with available title but not contain in category' do
        it 'notice and render all books' do
          expect(search).to redirect_to('/books')
          expect(flash[:notice]).to eq('Can not find books which have title or author like this')
        end
      end
    end
  end
end