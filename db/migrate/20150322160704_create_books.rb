class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, :null => false
      t.string :description, :null => false, :default => "No description available"
      t.integer :person_id, :null => false, :default => 0
      t.string :isbn, :null => false, :unique => true
      t.integer :pages, :null => false
      t.integer :publisher_id, :null => false
      t.date :publish_date, :null => false
      t.integer :category_id, :null => false
      t.date :due_date
      t.integer :user_id
			t.integer :holder_id
			t.boolean :renewed, :null => false, :default => false
      t.timestamps null: false
    end
  end
end
