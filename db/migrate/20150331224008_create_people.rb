class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :full_name, :null => false, :default => ''
			t.date :birthday, :null => false, :default => Date.new(1900,1,1)
			t.boolean :sex, :null => false, :default => true		# false = female, true = male
			t.string :photo
			t.integer :occupation_id, :null => false, :default => ''
      t.integer :book_id, :null => false, :default => 0
      t.integer :video_id, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
