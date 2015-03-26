class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title, :null => false, :default => ''
      t.string :description, :null => false, :default => ''
      t.integer :user_id
      t.integer :course_id
      t.integer :upload_id
			t.boolean :instructor_only, :null => false, :default => false

      t.timestamps null: false
    end
  end
end
