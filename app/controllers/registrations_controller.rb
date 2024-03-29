class RegistrationsController < Devise::RegistrationsController
	def new
		super
	end
	def create
		super
	end
	def update
		super
	end
	private
	def sign_up_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
	end
	def account_update_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache)
	end
end 
