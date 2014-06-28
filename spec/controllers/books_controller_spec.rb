require 'spec_helper'

describe BooksController do
  def paginated_books_array(options = {})
    Kaminari.paginate_array(books).page(options.fetch(:page, 0)).per(options.fetch(:per_page, per_page))
  end
  let!(:books) { create_list :book, per_page + 1 }
  let(:per_page) { Book.default_per_page }

  context 'GET index' do
    before do
      get :index, params
    end

    context 'not specify page' do
      let(:params) { {} }

      it 'assigns paginated books' do
        expect(assigns[:books]).to match_array(paginated_books_array)
      end
    end

    context 'specify page' do
      let(:page) { 2 }
      let(:params) { { page: page } }

      it 'assigns paginated books' do
        expect(assigns[:books]).to match_array(paginated_books_array(page: page))
      end
    end

    context 'change per page' do
      let(:per_page) { 15 }
      let(:params) { { per_page: per_page} }

      it 'assigns paginated books' do
        expect(assigns[:books]).to match_array(paginated_books_array(per_page: per_page))
      end
    end
  end

  context 'GET show' do
    before do
      get :show, id: books.first.id
    end

    it 'returns book' do
      expect(assigns[:book]).to eq books.first
    end
  end
end
