class CreateBooksCategoriesJoinTable < ActiveRecord::Migration
  def change
    create_table :books_categories, :id => false do |t|
      t.integer :book_id
      t.integer :category_id
    end

    add_index :books_categories, [:book_id, :category_id]
  end
end
