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
		if User.find(params[:id]).nil?
			flash[:error] = 'User does not exist.'
			redirect_to root_path
		else
			@user = User.find(params[:id])
		end

		authorize @user
  end

  def update
		if User.find(params[:id]).nil?
			flash[:error] = 'User does not exist.'
			redirect_to root_path
		else
		  @user = User.find(params[:id])
		  authorize @user
			@user.avatar = params[:avatar] 
			if @user.update_attributes(secure_params)
		    redirect_to :back, :notice => "User updated."
		  else
		    redirect_to users_path, :alert => "Unable to update user."
		  end
		end
  end

  def destroy
		if User.find(params[:id]).nil?
			flash[:error] = 'User does not exist.'
			redirect_to root_path
		else
		  user = User.find(params[:id])
		  authorize user
		  user.destroy
		  redirect_to users_path, :notice => "User deleted."
		end
  end

  private
		def secure_params
		  params.require(:user).permit(:role, :department_id, :avatar)
		end
end
