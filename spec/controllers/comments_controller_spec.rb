require 'spec_helper'

describe CommentsController do
  include_context 'login user'

  let(:book) { create :book }
  let(:user) { create :confirm_user}
  let(:comment_attributes) { attributes_for :comment, book_id: book.id, user_id: user.id }

  def create_comment
    post :create, comment: comment_attributes
  end

  context 'GET new' do
    let(:new_comment) { assigns[:comment] }

    before do
      get :new
    end

    it 'renders new comment' do
      expect(new_comment).to be_a(Comment)
      expect(new_comment).to be_new_record
    end
  end

  context 'POST create' do
    context 'create new comment successfully' do
      let!(:rating_average) { book.total_rating_value + comment_attributes[:rating] }
      let!(:total_count) { book.total_rating_count + 1 }

      before do
        create_comment
      end

      let(:new_comment) { Comment.last }

      it 'creates new comment with correct attributes' do
        comment_attributes.each do |key, value|
          expect(new_comment.send(key)).to eq value
        end
      end

      it 'shows message successfully' do
        expect(flash[:notice]).to eq('Thank you for your contribution')
      end

      it 'updates rating average and total rating count' do
        expect(book.reload.total_rating_value).to eq rating_average
        expect(book.total_rating_count).to eq total_count
      end
    end

    context 'Invalid comment attribute' do
      let(:comment_attributes) { { something: 'something', book_id: book.id } }

      before do
        create_comment
      end

      it 'fails to create comment' do
        expect do
          create_comment
        end.not_to change { Comment.count }
      end
    end
  end
end
