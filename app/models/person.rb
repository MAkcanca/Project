class Person < ActiveRecord::Base
	has_and_belongs_to_many :books, :join_table => 'books_people'

	validates :first_name, presence: true
	validates :last_name, presence: true

	def full_name
		"#{first_name} #{last_name}"
	end
end
