class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  before_filter :configure_permitted_parameters, if: :devise_controller?

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) do |u| 
			u.permit(:first_name,:last_name,:profile_name,:email, :password, :avatar, :avatar_cache)
		end
		devise_parameter_sanitizer.for(:account_update) do |u| 
			u.permit(:first_name,:last_name,:profile_name,:email, :password, :avatar, :avatar_cache)
		end
	end

	def is_number? (object)
		true if Float(object) rescue false
	end

	def authorize_student
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and current_user.student?
	end
	def authorize_instructor
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and current_user.instructor?
	end 
	def authorize_librarian
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and current_user.librarian?
	end
	def authorize_admin
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and current_user.admin?
	end
	def authorize_student_or_librarian
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and (current_user.student? or current_user.librarian?)
	end
	def authorize_student_or_instructor
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and (current_user.student? or current_user.instructor?)
	end
	def authorize_instructor_or_admin
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and (current_user.instructor? or current_user.admin?)
	end
	def authorize_student_instructor_or_admin
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and (current_user.student? or current_user.instructor? or current_user.admin?)
	end
	def authorize_initialized
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and not current_user.uninitialized?
	end
	def authorized_not_librarian
		redirect_to root_path, alert: 'Access denied.' unless user_signed_in? and not current_user.librarian?
	end
	def mobile_device?
		request.user_agent =~ /Mobile|webOS/
	end
	helper_method :mobile_device?

  def record_not_found
		flash[:error] = 'Record not found.'
		redirect_to root_path
  end
end
