class Department < ActiveRecord::Base
	has_many :courses
	has_many :users

	validates :title, presence: true
	validates :abbreviation, presence: true

	validates_uniqueness_of :title, :case_sensitive => false
	validates_uniqueness_of :abbreviation, :case_sensitive => false

	validates_length_of :abbreviation, :minimum => 2, :maximum => 3
end
