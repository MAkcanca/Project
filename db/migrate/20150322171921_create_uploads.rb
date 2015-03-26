class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :title, :null => false
      t.string :attachment, :null => false
      t.integer :user_id, :null => false
      t.integer :course_id, :null => false
			t.integer :folder_id, :null => false

      t.timestamps null: false
    end
  end
end

