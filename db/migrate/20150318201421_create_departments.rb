class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :title, :null => false
      t.string :abbreviation, :null => false

      t.timestamps null: false
    end
  end
end
