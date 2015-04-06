class DepartmentsController < ApplicationController
	before_filter :authorize_admin, :except => [:index, :show]

  def index
		@departments = Department.all
  end

  def new
  end
	def create
		if user_signed_in? and current_user.admin?
			@department = Department.new(secure_params)
			if @department.save
				flash[:notice] = 'Added department!'
				redirect_to departments_path
			else
				flash[:error] = @department.errors.full_messages.to_sentence.humanize
				render 'new'
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end
  def edit
		if Department.find(params[:id])
			flash[:error] = 'Department does not exist.'
			redirect_to root_path
		else
			@department = Department.find(params[:id])
		end
  end
  def update
		if user_signed_in? and current_user.admin?
			if Department.find(params[:id])
				flash[:error] = 'Department does not exist.'
				redirect_to root_path
			else
		  	@department = Department.find(params[:id])
	
				if @department.update(secure_params)
					flash[:notice] = "Successfully updated the course #{@department.title}!"
					redirect_to department_path(@department.id)
				else
					flash[:error] = @department.errors.full_messages.to_sentence.humanize
					render 'edit'
				end
			end
		else
			flash[:error] = 'Access denied.'
		end
  end
	def show
		if Department.find(params[:id])
			flash[:error] = 'Department does not exist.'
			redirect_to root_path
		else
			@department = Department.find(params[:id])
			@current_semester = Semester.where('start_date < ? AND end_date > ?', Date.today, Date.today).first
		end
	end
	def destroy
		if Department.find(params[:id])
			flash[:error] = 'Department does not exist.'
			redirect_to root_path
		else
			@department = Department.find(params[:id])
		
			if @department.courses.empty?
				@department.users.each do |user|
					user.update_attribute(:department_id, Department.where('title = ?', 'Uninitialized').first.id)
				end
				@department.destroy
				redirect_to departments_path
			else
				flash[:error] = 'Cannot delete a department with courses.'
				redirect_to :back
		 	end
		end
	end

	private
		def secure_params
		  params[:department].permit(:title,:abbreviation)
		end
end
