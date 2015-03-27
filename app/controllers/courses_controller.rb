class CoursesController < ApplicationController
  before_filter :authorize_student_instructor_or_admin, :except => [:index, :show]

  def index
    @q = Course.ransack(params[:q])
    @courses = @q.result(distinct:true)
		@collapse = @courses.count != Course.all.count
  end

  def show
    @course = Course.find(params[:id])
    @course_id = "%04d" % @course.course_number.to_s
		@instructor = User.find(@course.instructor_id)
  end

  def new
  end

  def edit
		if user_signed_in? and (current_user.admin? or (current_user.instructor? and current_user.id == Course.find(params[:id]).instructor_id))
		  @course = Course.find(params[:id])
			@disabled = @course.semester.start_date + 10.days < Date.today
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
  end

  def update
		if user_signed_in? and current_user.admin?
		  @course = Course.find(params[:id])

			if @course.update(secure_params)
				flash[:notice] = "Successfully updated the course #{@course.title}!"
				redirect_to course_path(@course.id)
			else
				flash[:error] = @course.errors.full_messages.to_sentence.humanize
				render 'edit'
			end
		else
			flash[:error] = 'Access denied.'
		end
  end

  def create
		if user_signed_in? and current_user.admin?
		  @course = Course.new(secure_params)

		  if @course.save
		    flash[:notice] = "Course created!"
		    redirect_to @course
		  else
		    flash[:error] = @course.errors.full_messages.to_sentence.humanize
		    render 'new'
		  end
		else
			flash[:error] = "Access denied."
			redirect_to root_path
		end
  end

  def enroll
    @course = Course.find(params[:course])
    if not current_user.courses.include? @course and @course.enrolled < @course.capacity and @course.semester.start_date + 10.days > Date.today
      current_user.course_ids = current_user.course_ids << @course.id
      @course.enrolled = @course.users.size
      @course.save!

      respond_to do |format|
        format.html {redirect_to course_path(@course.id) }
        format.js
      end
		end
  end

  def drop
    @course = Course.find(params[:course])
    if user_signed_in? and @course.users.include? current_user and @course.semester.start_date + 10.days > Date.today
      courses = current_user.course_ids
      current_user.course_ids = courses - [@course.id]
      @users = @course.users
      @course.user_ids = @users - [current_user.id]
      @course.enrolled = @course.users.size
      @course.save!

      respond_to do |format|
        format.html {redirect_to course_path(@course.id) }
        format.js
      end
    end
  end

  def destroy
		if user_signed_in? and current_user.admin?
		  @course = Course.find(params[:id])
		  @course.destroy
		  redirect_to courses_path
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
  end

  private
  def secure_params
    params[:course].permit(:title,:m,:t,:w,:r,:f,:department_id,:semester_id,:description,:capacity,:course_number,:instructor_id)
  end
end
