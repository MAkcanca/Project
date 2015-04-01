class CreatePeopleVideosJoinTable < ActiveRecord::Migration
  def change
		create_table :people_videos, :id => false do |t|
			t.integer :person_id
			t.integer :video_id
		end
		
		add_index :people_videos, [:person_id, :video_id]
  end
end
