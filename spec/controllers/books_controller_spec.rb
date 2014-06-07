require 'spec_helper'

describe BooksController do

  context 'GET index' do
    let!(:books) { create_list :book, 5 }
    
    before do
      get :index
    end

    it 'render all books' do
      expect(assigns[:books]).to eq books
    end
  end
end
