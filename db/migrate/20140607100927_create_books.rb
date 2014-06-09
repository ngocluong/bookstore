class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :image_url, default: 'book.png'
      t.string :author_name, default: 'N/A'
      t.string :publisher_name, default: 'N/A'
      t.date :published_date
      t.float :unit_price, default: 0.01
      t.integer :total_rating_value, default: 0
      t.integer :total_rating_count, default: 0

      t.timestamps
    end
  end
end
