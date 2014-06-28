require 'spec_helper'

describe Comment do
  let(:book) { create :book }

  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
  it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  it { should validate_presence_of :content }
  it { should validate_presence_of :user }
  it { should validate_presence_of :book }
  it { should belong_to :user }
  it { should belong_to :book }

  describe '#update_total_rating' do
    let(:rating) { 1 }
    let(:comment) { create :comment, book: book, rating: rating }

    it 'increases book rating value' do
      expect { comment }.to change { book.total_rating_value }.by(rating)
    end

    it 'increases book rating value' do
      expect { comment }.to change { book.total_rating_count }.by(1)
    end
  end

  describe '#clear_comment_cache' do
    before do
      expect(Comment::Cachier).to receive(:clear_cache).with(book: book)
    end

    it 'invokes comment cache clearer' do
      create(:comment, book: book)
    end
  end
end

