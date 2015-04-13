class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
			t.string :title, :null => false, :default => '', :unique => true
      t.timestamps null: false
    end
  end
end
