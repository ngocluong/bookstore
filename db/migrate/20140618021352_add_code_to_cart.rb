class AddCodeToCart < ActiveRecord::Migration
  def change
    add_column :carts, :code, :string
  end
end
