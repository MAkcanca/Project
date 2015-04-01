class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
			t.string :title, :null => false, :default => ''
      t.timestamps null: false
    end
  end
end
