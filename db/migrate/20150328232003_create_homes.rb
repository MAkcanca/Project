class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
			t.string :title, :null => false, :default => ""
			t.string :description, :null => false, :default => ""
			
      t.timestamps :null =>false
    end
  end
end
