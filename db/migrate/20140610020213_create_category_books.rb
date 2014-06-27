class CreateCategoryBooks < ActiveRecord::Migration
  def change
    create_table :category_books do |t|
      t.references :book, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
