class Article < ActiveRecord::Base
	belongs_to :course
	belongs_to :user

	validates :title, presence: true
	validates :description, presence: true
	validates :course_id, presence: true
end
