require 'spec_helper'

describe BooksController do

  context 'GET index' do

    context 'not pagination' do
      let!(:books) { create_list :book, 5 }

      before do
        get :index
      end

      it 'renders all books' do
        expect(assigns[:books]).to match_array books
      end
    end
  end

  context 'pagination' do
    let(:per_page) { Book.default_per_page }
    let!(:books) { create_list :book, per_page + 1 }

    before do
      get :index
    end

    it 'assigns paginated books' do
      expect(assigns[:books]).to match_array Book.first(per_page)
    end
  end
end
