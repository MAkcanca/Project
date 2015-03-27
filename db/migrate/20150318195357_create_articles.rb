class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :null => false, :default => ''
      t.string :description, :null => false, :default => ''
      t.integer :course_id, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
