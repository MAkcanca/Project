class Person < ActiveRecord::Base
	has_and_belongs_to_many :videos
	has_and_belongs_to_many :occupations
end
