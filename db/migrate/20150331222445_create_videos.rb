class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
			t.string :title, :null => false, :default => ''
			t.integer :director, :null => false, :default => 0
			t.integer :producer, :null => false, :default => 0
			t.integer :screenplay_writer, :null => false, :default => 0
			t.integer :person_id, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
