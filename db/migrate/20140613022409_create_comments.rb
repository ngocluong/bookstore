class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :rating
      t.text  :content
      t.references :book, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
