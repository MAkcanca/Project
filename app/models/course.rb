class Course < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :grades
	has_many :folders
	belongs_to :semester
	belongs_to :department
end
