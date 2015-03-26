class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :title, :null => false, :default => ''
      t.date :start_date, :null => false, :default => Date.new(1900,1,1)
      t.date :end_date, :null => false, :default => Date.new(1900,1,1)
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
