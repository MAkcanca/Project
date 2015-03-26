class Book < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :category

	validates :title, presence: true
	validates :author, presence: true
	validates :description, presence: true
	validates :pages, presence: true
	validates :isbn, presence: true
	validates :publisher, presence: true
	validates :publish_date, presence: true
	validates :category_id, presence: true
	validates :isbn, uniqueness: true
end
