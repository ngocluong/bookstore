require 'spec_helper'

describe BooksController do

  context 'GET index' do

    context 'Store has less than 9 books' do
      let!(:books) { create_list :book, 5 }

      before do
        get :index
      end

      it 'render all books' do
        expect(assigns[:books]).to eq books
      end
    end
  end

  context 'Store has more than 9 books' do
    let!(:books) { create_list :book, 20 }

    before do
      get :index
    end

    it 'render first 9 book' do
      expect(assigns[:books]).to eq Book.first(9)
    end
  end
end
