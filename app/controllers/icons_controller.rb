class IconsController < ApplicationController
	before_filter :authorize_student_or_instructor

  def index
		if current_user.student?
			@courses = current_user.courses
		elsif current_user.instructor?
			@courses = Course.where('instructor_id = ?', current_user.id)
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
		@semesters = Semester.where("end_date >= ?", current_user.created_at).reverse
  end
 
  def show
	 	if not current_user.id == Course.find(params[:id]).instructor_id and not current_user.courses.include? Course.find(params[:id]) 
			redirect_to root_path, :flash => { :error => "Access denied." }
		else
			if params[:id].to_i > Course.all.count or params[:id].to_i < 0
				flash[:error] = 'Course does not exist.'
				redirect_to root_path
			else
				@course = Course.find(params[:id])
				if current_user.student? 
					@grades = Grade.where('user_id = ? AND course_id = ?', current_user.id, @course.id)
				elsif current_user.instructor?
					@grades = Grade.where('course_id = ?', params[:id])
					@students = @course.users
				end
				@folder = Folder.where('course_id = ? AND instructor_only = ?', params[:id], false)
				@instructor_uploads = Folder.where('course_id = ? AND instructor_only = ?', params[:id], true)
				@articles = Article.where('course_id = ?', @course.id).reverse
			end
		end
  end
end
