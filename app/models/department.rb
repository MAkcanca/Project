class Department < ActiveRecord::Base
	has_many :courses
	has_many :users

	validates :title, presence: true
	validates :abbreviation, presence: true

	validates :title, uniqueness: true
	validates :abbreviation, presence: true

	validates_length_of :abbreviation,
											:within => 1..3,
											:too_short => 'Abbreviation is too short',
											:too_long => 'Abbreviation is too long'
end
