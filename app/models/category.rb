class Category < ActiveRecord::Base
	has_many :books

	validates :title, presence: true
	validates_uniqueness_of :title, :case_sensitive => false
end
