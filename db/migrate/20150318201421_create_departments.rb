class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :title, :null => false, :unique => true, :default => ''
      t.string :abbreviation, :null => false, :unique => true,  :default => ''

      t.timestamps null: false
    end
  end
end
