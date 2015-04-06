class GradesController < ApplicationController
	before_filter :authorize_instructor

	def edit
		if user_signed_in? and current_user.instructor? and Grade.find(params[:id]).course.instructor_id == current_user.id
			if params[:id].to_i > Grade.all.count or params[:id].to_i < 0
				flash[:error] = 'Grade does not exist.'
				redirect_to root_path
			else
				@grade = Grade.find(params[:id])
			end
		else
			redirect_to root_path, :flash => { :error => "Access denied." }
		end
	end
	 
	def new
		if not params[:course_id].nil? and params[:id].to_i < Grade.all.count or params[:id].to_i >= 0
			@course_id = params[:course_id]
		else
			flash[:error] = 'Error handling course ID.']
			redirect_to root_path
		end
	end

	def create
		@grade = Grade.new(secure_params)
		if user_signed_in? and current_user.instructor? and current_user.id == Course.find(@grade.course_id).instructor_id
			title = @grade.title
			max_score = @grade.max_score
			course_id = @grade.course_id

			@course = Course.find(course_id)
			@course.users.each do |u|
				@new_grade = Grade.new(title:title, max_score:max_score, course_id:course_id, user_id:u.id)
				@new_grade.save
			end
		
			if @new_grade.nil?
				flash[:error] = "Sorry, you can only add grades when there are users in the class."
				redirect_to icon_path(@grade.course_id)
			else		
				flash[:notice] = "Successfully created new grade option '#{@new_grade.title}' for #{@course.title}."
				redirect_to icon_path(@grade.course_id)
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end

  def show
		if user_signed_in? and current_user.instructor? and Grade.find(params[:id]).course.instructor_id == current_user.id
			if params[:id].to_i > Grade.all.count or params[:id].to_i < 0
				flash[:error] = 'Grade does not exist.'
				redirect_to root_path
			else
			  @grade = Grade.find(params[:id])
				@student = @grade.user
			end
		else
			redirect_to root_path, :flash => { :error => "Access denied." }
		end
  end

  def destroy
		redirect_to root_path
  end

	def update
		if user_signed_in? and current_user.instructor?
			if params[:id].to_i > Grade.all.count or params[:id].to_i < 0
				flash[:error] = 'Grade does not exist.'
				redirect_to root_path
			else
				@grade = Grade.find(params[:id])
				if @grade.update(secure_params)
					flash[:notice] = "Successfully updated the grade for #{@grade.title} for #{@grade.user.first_name} #{@grade.user.last_name}."
					redirect_to icon_path(@grade.course_id)
				else
					render 'edit'
				end
			end
		else
			flash[:notice] = 'Access denied.'
			redirect_to root_path
		end
	end
	def destroy
		if params[:id].to_i > Grade.all.count or params[:id].to_i < 0
			flash[:error] = 'Grade does not exist.'
			redirect_to root_path
		else
			@grade = Grade.find(params[:id])
			@grade.destroy
		 
			redirect_to grades_path
		end
	end
	private 
		def secure_params
			params.require(:grade).permit(:title,:score,:max_score,:course_id)
		end
end
