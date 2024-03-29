class Book < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :category
	has_and_belongs_to_many :people, :join_table => 'books_people'
	belongs_to :publisher

	validates :title, presence: true
	validates :person_id, presence: true
	validates :description, presence: true
	validates :pages, presence: true
	validates :isbn, presence: true
	validates :publisher_id, presence: true
	validates :publish_date, presence: true
	validates :category_id, presence: true
	validates_uniqueness_of :isbn, :case_sensitive => false
end
