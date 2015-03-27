class Semester < ActiveRecord::Base
	has_many :courses

	validates :title, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true

	# Makes sure the dates don't overlap
	validates :start_date, :end_date, :overlap => true
end
