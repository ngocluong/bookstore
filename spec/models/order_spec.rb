require 'spec_helper'

describe Order do
  [:name, :address, :email].each do |attr|
    it { should validate_presence_of attr }
  end
  it { should have_many(:line_items).dependent(:destroy) }
end
