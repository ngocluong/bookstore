require 'spec_helper'

describe StoreController do

  context 'GET index' do
    before do
      get :index
    end

    it 'renders all books' do
      expect(response).to redirect_to(books_path)
    end
  end
end
