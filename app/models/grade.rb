class Grade < ActiveRecord::Base
	belongs_to :user
	belongs_to :course

	validates :title, presence: true
	validates :score, presence: true
	validates :max_score, presence: true
	validates :user_id, presence: true
	validates :course_id, presence: true
	validates_uniqueness_of :title, :case_sensitive => false
end
