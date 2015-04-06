class ArticlesController < ApplicationController
  before_filter :authorize_student_or_instructor
	
	def new
	  @article = Article.new
		@course_id = params[:course_id]
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
		if params[:id] > Article.all.count
			flash[:error] = 'Article does not exist.'
			redirect_to root_path
		end
    @article = Article.find(params[:id])
  end

	def edit
		if params[:id] > Article.all.count
			flash[:error] = 'Article does not exist.'
			redirect_to root_path
		end
		@article = Article.find(params[:id])
	end

	def update
		if user_signed_in? and current_user.instructor?
			@article = Article.find(params[:id])
		 
			if @article.update(article_params)
				redirect_to @article
			else
				render 'edit'
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
	 
		redirect_to articles_path
	end
	private
		def article_params
		  params.require(:article).permit(:title, :description, :course_id)
		end
end
