require 'spec_helper'

describe Comment do
  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
  it { should validate_presence_of :content }
  it { should belong_to :user }
  it { should belong_to :book }
end

