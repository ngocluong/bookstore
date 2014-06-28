require 'spec_helper'

describe Book do
	it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0.01) }
	it { should validate_uniqueness_of(:title) }
	it { should have_many(:category_books).dependent(:destroy) }
	it { should have_many(:comments).dependent(:destroy) }
	it { should have_many(:categories).through(:category_books) }
	it { should have_many :line_items }

	[:title, :description, :image_url, :unit_price, :published_date].each do |attr|
		it { should validate_presence_of attr }
	end

	['abc', 'image.doc', 'image.h'].each do |invalid|
		it { should_not allow_value(invalid).for(:image_url) }
	end

	['image.png', 'image.jpg', 'image.gif', 'image.jpeg'].each do |valid|
		it { should allow_value(valid).for(:image_url) }
	end
end
