class Folder < ActiveRecord::Base
	has_many :uploads
	belongs_to :course

	validates :title, presence: true
	validates :description, presence: true

	validates_uniqueness_of :title, :case_sensitive => false
end
