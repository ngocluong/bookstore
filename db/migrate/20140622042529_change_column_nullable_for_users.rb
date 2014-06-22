class ChangeColumnNullableForUsers < ActiveRecord::Migration
  def change
    change_column_null(:users, :phone, true)
    change_column_null(:users, :birthday, true)
  end
end
