class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :title, :null => false, :default => ''
      t.string :abbreviation, :null => false, :default => ''

      t.timestamps null: false
    end
  end
end
