require 'spec_helper'

describe CategoryBook do
  it { should belong_to :book }
  it { should belong_to :category }
end
