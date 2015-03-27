class Course < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :grades
	has_many :folders
	belongs_to :semester
	belongs_to :department

	validates :title, presence: true
	validates :department_id, presence: true
	validates :semester_id, presence: true
	validates :description, presence: true
	validates :capacity, presence: true
	validates :course_number, presence: true
	validates :instructor_id, presence: true

	validates :course_number, :uniqueness => {:scope => [:department_id, presence: true]}
end
