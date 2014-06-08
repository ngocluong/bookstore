require 'spec_helper'

describe BooksController do

  context 'GET index' do
    
    context 'Store has less than 10 books' do
      let!(:books) { create_list :book, 5 }
      
      before do
        get :index
      end

      it 'render all books' do
        expect(assigns[:books]).to eq books
      end
    end
  end

  context 'Store has more than 10 books' do
    let!(:books) { create_list :book, 20 }
    
    before do
      get :index  
    end

    it 'render first 10 book' do
      expect(assigns[:books]).to eq Book.first(10)
    end
  end
end
