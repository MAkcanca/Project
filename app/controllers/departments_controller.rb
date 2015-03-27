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
		@department = Department.find(params[:id])
  end
  def update
		if user_signed_in? and current_user.admin?
		  @department = Department.find(params[:id])

			if @department.update(secure_params)
				flash[:notice] = "Successfully updated the course #{@department.title}!"
				redirect_to department_path(@department.id)
			else
				flash[:error] = @department.errors.full_messages.to_sentence.humanize
				render 'edit'
			end
		else
			flash[:error] = 'Access denied.'
		end
  end
	def show
		@department = Department.find(params[:id])
		@current_semester = Semester.where('start_date < ? AND end_date > ?', Date.today, Date.today).first
	end

	private
		def secure_params
		  params[:department].permit(:title,:abbreviation)
		end
end
