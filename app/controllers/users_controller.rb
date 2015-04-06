class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
		@q = User.ransack(params[:q])
		@users = @q.result(distinct:true)
		@collapse = @users.count != User.all.count
    authorize @users
  end

  def show
		@user = User.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path

		authorize @user
  end

  def update
	  @user = User.find(params[:id])
	  authorize @user
		@user.avatar = params[:avatar] 
		if @user.update_attributes(secure_params)
	    redirect_to :back, :notice => "User updated."
	  else
	    redirect_to users_path, :alert => "Unable to update user."
	  end
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
  end

  def destroy
	  user = User.find(params[:id])
	  authorize user
	  user.destroy
	  redirect_to users_path, :notice => "User deleted."
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
  end

  private
		def secure_params
		  params.require(:user).permit(:role, :department_id, :avatar)
		end
end
