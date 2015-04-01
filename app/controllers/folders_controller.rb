class FoldersController < ApplicationController
	before_filter :authorize_student_or_instructor

	def index
		redirect_to root_path
	end

  def show
		if user_signed_in? and 
			((current_user.instructor? and current_user.id == Folder.find(params[:id]).course.instructor_id) or 
			 (current_user.student?    and current_user.courses.include? Folder.find(params[:id]).course))
				@folder = Folder.find(params[:id])
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
  end

  def new
		@folder = Folder.new
		@course_id = params[:course_id]
  end

	def create
		if user_signed_in? and current_user.instructor?
			@folder = Folder.new(secure_params)

			closedate = Date.civil(params[:close_date][:year].to_i, params[:close_date][:month].to_i, params[:close_date][:day].to_i)

			if @folder.save
				@folder.update_attributes(close_date: closedate)
				flash[:notice] = "Successfully created a new folder '#{@folder.title}' for '#{@folder.course.title}'!"
				redirect_to icon_path(@folder.course.id)
			else
				flash[:error] = @folder.errors.full_messages.to_sentence.humanize
				render 'new'
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end

  def edit
		redirect_to root_path
  end

  def update
		redirect_to root_path
  end

  def destroy
		redirect_to root_path
  end

	private
		def secure_params
		  params.require(:folder).permit(:title, :description, :course_id, :instructor_only)
		end
end
