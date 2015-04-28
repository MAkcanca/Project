class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
		@q = User.ransack(params[:q])
		@users = @q.result(distinct:true)
		@collapse = @users.count != User.all.count
		@users.order! 'first_name ASC'
    authorize @users
  end

  def show
		@user = User.find(params[:id])
		authorize @user
  end

  def update
	  @user = User.find(params[:id])
	  authorize @user
		@user.avatar = params[:avatar] 
		@user.update_attributes(secure_params)
		respond_to do |format|
			format.html {redirect_to user_path(@user.id) }
			format.js { :notice => "Updated user!" }
		end
  end

  def destroy
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
