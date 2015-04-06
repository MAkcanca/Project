class UploadsController < ApplicationController
	before_filter :authorize_student_or_instructor
	
  def index
		@uploads = Upload.all
  end

  def new
		@file = Upload.new
		@course_id = params[:course_id]
		redirect_to icons_path unless not @course_id.nil? 
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
  end
	
  def create
		@course_id = params[:course_id]
		@file = Upload.new(secure_params)
		@file.update_attributes(:user_id => current_user.id)

		if @file.save
			redirect_to icon_path(@file.course.id), :notice => "The file '#{@file.title}' has been uploaded for '#{@file.course.title}'."
		else
			flash[:error] = @file.errors.full_messages.to_sentence.humanize
			redirect_to :back
		end
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
  end

	def show
	 	if not current_user.id == Course.find(params[:id]).instructor_id or not current_user.courses.include? Course.find(params[:id]) 
			redirect_to root_path, :flash => { :error => "Access denied." }
		else
			@uploads = Upload.where(:course_id => params[:id])
		end
	end

  def destroy
		@file = Upload.find(params[:id])
		@file.destroy
		redirect_to session.delete(:return_to), :notice => "The file '#{@file.title}' has been deleted."

		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
  end

	private 
		def secure_params
			params.require(:upload).permit(:title,:attachment,:user_id,:course_id,:folder_id)
		end
end
