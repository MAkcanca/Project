class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.integer :course_id, :null => false

      t.timestamps null: false
    end
  end
end
