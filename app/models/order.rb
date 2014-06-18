class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true

end
