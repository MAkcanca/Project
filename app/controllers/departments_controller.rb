class DepartmentsController < ApplicationController
	before_filter :authorize_admin

  def index
		@departments = Department.all
  end

  def new

  end
	def create
		if user_signed_in? and current_user.admin?
			@department = Department.new(secure_params)
			if @department.abbreviation.length < 2 or @department.abbreviation.length > 3
				flash[:error] = 'Attribute must be 2 or 3 characters long.'
				render 'new'
			else
				@department.update_attribute(:abbreviation, @department.abbreviation.upcase)
				if @department.save
					flash[:notice] = 'Added department!'
					redirect_to departments_path
				else
					flash[:error] = @department.errors.full_messages.to_sentence.humanize
					render 'new'
				end
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end
  def edit
  end
	def show
		@department = Department.find(params[:id])
	end

	private
		def secure_params
		  params[:department].permit(:title,:abbreviation)
		end
end
