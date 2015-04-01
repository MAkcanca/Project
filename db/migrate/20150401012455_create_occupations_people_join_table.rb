class CreateOccupationsPeopleJoinTable < ActiveRecord::Migration
  def change
		create_table :occupations_people, :id => false do |t|
			t.integer :occupation_id
			t.integer :person_id
		end

		add_index :occupations_people, [:occupation_id, :person_id]
  end
end
