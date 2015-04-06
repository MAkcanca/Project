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
		if params[:id] > User.all.count
			flash[:error] = 'User does not exist.'
			redirect_to root_path
		end
		@user = User.find(params[:id])
		authorize @user
  end

  def update
		if params[:id] > User.all.count
			flash[:error] = 'User does not exist.'
			redirect_to root_path
		end
    @user = User.find(params[:id])
    authorize @user
		@user.avatar = params[:avatar] 
		if @user.update_attributes(secure_params)
      redirect_to :back, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
		if params[:id] > User.all.count
			flash[:error] = 'User does not exist.'
			redirect_to root_path
		end
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private
		def secure_params
		  params.require(:user).permit(:role, :department_id, :avatar)
		end
end
