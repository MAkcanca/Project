class Semester < ActiveRecord::Base
	has_many :courses

	validates :title, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
end
