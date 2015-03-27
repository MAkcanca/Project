class Department < ActiveRecord::Base
	has_many :courses
	has_many :users

	validates :title, presence: true
	validates :abbreviation, presence: true

	validates :title, uniqueness: true
	validates :abbreviation, presence: true
end
