class ArticlesController < ApplicationController
  before_filter :authorize_student_or_instructor
	
	def new
	  @article = Article.new
		@course_id = params[:course_id]
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
	end

	def create
		if user_signed_in? and current_user.instructor? 
			@article = Article.new(article_params)
		 
			if @article.save
				redirect_to @article
			else
				flash[:error] = "News item title and text must be at least 5 characters long."
				redirect_to :back
			end
		else
			flash[:error] = "Access denied."
			redirect_to root_path 
		end
	end
	
	def index
		redirect_to root_path
	end

	def show
    @article = Article.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
  end

	def edit
		@article = Article.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
	end

	def update
		if user_signed_in? and current_user.instructor?
			@article = Article.find(params[:id])
		 	
			if @article.update(article_params)
				redirect_to @article
			else
				render 'edit'
			end

			rescue ActiveRecord::RecordNotFound
				flash[:error] = 'Record not found.'
				redirect_to root_path
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
	 
		redirect_to articles_path

		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
	end
	private
		def article_params
		  params.require(:article).permit(:title, :description, :course_id)
		end
end
