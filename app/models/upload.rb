class Upload < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
	validates :title, presence: true
	
	belongs_to :user
	belongs_to :course
end
