class SemestersController < ApplicationController
  before_filter :authorize_admin
	respond_to :html, :json
	def index
		@semesters = Semester.all
	end

  def new
		@semester = Semester.new
  end

	def create
		if user_signed_in? and current_user.admin? 
			@semester = Semester.new(secure_params)
			if Date.valid_date?(params[:start_date][:year].to_i,params[:start_date][:month].to_i,params[:start_date][:day].to_i) and Date.valid_date?(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i)
				startdate = Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
				enddate = Date.civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i)
				if enddate < startdate
					tmp = startdate
					startdate = enddate
					enddate = tmp
				end

				@semester.update_attributes(start_date: startdate, end_date: enddate)
		
				if @semester.save
					flash[:notice] = 'Successfully created new semester!'
					redirect_to semesters_path
				else
					flash[:error] = @semester.errors.full_messages.to_sentence.humanize
					render 'new'
				end
			else
				flash[:error] = 'Invalid date'
				render 'new'
			end		

		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end

	def show
		if params[:id] > Semester.all.count
			flash[:error] = 'Semester does not exist.'
			redirect_to root_path
		end
		@semester = Semester.find(params[:id])
	end
	def edit
		redirect_to root_path
	end
	def update
		redirect_to root_path
	end
	def destroy
		if user_signed_in? and current_user.admin? 
			if params[:id] > Semester.all.count
				flash[:error] = 'Semester does not exist.'
				redirect_to root_path
			end
		  semester = Semester.find(params[:id])
		  semester.destroy
			flash[:notice] = 'Successfully deleted a semester.'
		  redirect_to semesters_path
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
  end

	private
		def secure_params
		  params.require(:semester).permit(:title, :start_date,:end_date,:category_id)
		end
end
