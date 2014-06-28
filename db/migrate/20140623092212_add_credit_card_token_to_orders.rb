class AddCreditCardTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :credit_card_number, :string
  end
end
