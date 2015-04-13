class Semester < ActiveRecord::Base
	has_many :courses

	validates :title, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates_uniqueness_of :title, :case_sensitive => false

	# Makes sure the dates don't overlap
	validates :start_date, :end_date, :overlap => true
	def valid_start_date?
    errors.add(:start_date, 'must be a valid date.') if ((Date.parse(start_date) rescue ArgumentError) == ArgumentError)
	end
	def valid_end_date?
    errors.add(:end_date, 'must be a valid date.') if ((Date.parse(end_date) rescue ArgumentError) == ArgumentError)
	end
end
