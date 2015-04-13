class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :title, :null => false, :unique => true
      t.integer :score, :default => 0
      t.integer :max_score, :default => 0
      t.integer :user_id, :null => false, :default => 0
			t.integer :course_id, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
