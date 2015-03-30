class User < ActiveRecord::Base
	has_many :grades
	has_many :books
	has_many :uploads
	belongs_to :department
	has_and_belongs_to_many :books, :join_table => 'books_users'
	has_and_belongs_to_many :courses, :join_table => 'courses_users'
	mount_uploader :avatar, AvatarUploader
  enum role: [:uninitialized, :student, :instructor, :librarian, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :uninitialized
  end
	def full_name
		"#{first_name} #{last_name}"
	end

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates :password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
