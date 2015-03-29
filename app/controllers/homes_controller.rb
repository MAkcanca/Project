class HomesController < ApplicationController
	def index
		redirect_to root_path
	end

	def show
		redirect_to root_path
	end

	def new
		redirect_to root_path
	end

	def create
		redirect_to root_path
	end

	def edit
		@home = Home.first
	end

	def update
		if user_signed_in? and current_user.admin?
			@home = Home.first
			
			if @home.update_attribute(secure_params)
				flash[:notice] = 'Successfully updated description!'
				redirect_to root_path
			else
				flash[:error] = @home.errors.full_messages.to_sentence.humanize
				render 'edit'
			end
		end
	end
	private
		def secure_params
		  params.require(:home).permit(:title, :description)
		end
end
