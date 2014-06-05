class EnableLockableForUsers < ActiveRecord::Migration
  def change
    change_table :users, bulk: true do |t|
      t.integer  :failed_attempts, default: 0
      t.string   :unlock_token
      t.datetime :locked_at
      add_index :users, :unlock_token,  unique: true
    end
  end
end
