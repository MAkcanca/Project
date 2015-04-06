class CreateBooksPeopleJoinTable < ActiveRecord::Migration
  def change
		create_table :books_people, :id => false do |t|
			t.integer :book_id
			t.integer :person_id
		end

		add_index :books_people, [:book_id, :person_id]
  end
end
