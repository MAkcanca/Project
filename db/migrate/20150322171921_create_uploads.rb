class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :title, :null => false, :default => ''
      t.string :attachment, :null => false, :default => ''
      t.integer :user_id, :null => false, :default => 0
      t.integer :course_id, :null => false, :default => 0
			t.integer :folder_id, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end

