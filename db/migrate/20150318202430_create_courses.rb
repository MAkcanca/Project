class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, :null => false
      t.string :description, :null => false
			t.integer :enrolled, :null => false, :default => 0
			t.integer :capacity, :null => false, :default => 0
      t.integer :user_id
      t.integer :instructor_id, :null => false, :default => 0
      t.integer :semester_id, :null => false, :default => 0
			t.integer :department_id, :null => false, :default => 0
			t.string :course_number, :null => false, :unique => true
      t.boolean :m, :null => false, :default => false
      t.boolean :t, :null => false, :default => false
      t.boolean :w, :null => false, :default => false
      t.boolean :r, :null => false, :default => false
      t.boolean :f, :null => false, :default => false

      t.timestamps null: false
    end
  end
end
