require 'spec_helper'

describe CommentsController do
  let!(:book) { create :book }
  let!(:user) { create :user}
  let(:comment_attributes) { attributes_for :comment, book_id: book.id, user_id: user.id }

  def create_comment
    post :create, comment: comment_attributes
  end

  context "GET new" do
    let(:new_comment) { assigns[:comment] }

    before do
      get :new
    end

    it "renders new comment" do
      expect(new_comment).to be_a(Comment)
      expect(new_comment).to be_new_record
    end
  end

  context "POST create" do
    before do
      create_comment
    end

    context "create new comment successfully" do
      let(:new_comment) { Comment.last }

      it 'creates new comment with correct attributes' do
        comment_attributes.each do |key, value|
          expect(new_comment.send(key)).to eq value
        end
      end

      it 'should show message successfully' do
        flash[:notice].should eq('Thank you for your contribution')
      end
    end

    context "can not create new comment" do
      let(:comment_attributes) { { something: 'something' } }

      it 'fails to create comment' do
        expect do
          create_comment
        end.not_to change { Comment.count }
      end
    end
  end
end
