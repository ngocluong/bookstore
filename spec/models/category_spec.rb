require 'spec_helper'

describe Category do
  it { should have_many :category_books }
  it { should have_many(:books).through(:category_books) }
end
