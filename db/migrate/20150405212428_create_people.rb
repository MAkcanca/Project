class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
			t.string :first_name, :null => false, :default => ''
			t.string :last_name, :null => false, :default => ''
      t.timestamps null: false
    end
  end
end
