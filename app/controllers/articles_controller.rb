class ArticlesController < ApplicationController
  before_filter :authorize_student_or_instructor
	
	def new
	  @article = Article.new
		if params[:course].nil?
			flash[:error] = 'Error in fetching news items.'
			redirect_to root_path
		else
			@course_id = params[:course_id]
		end
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
		if params[:id].to_i > Article.all.count or params[:id].to_i < 0
			flash[:error] = 'Article does not exist.'
			redirect_to root_path
		else
	    @article = Article.find(params[:id])
		end
  end

	def edit
		if params[:id].to_i > Article.all.count or params[:id].to_i < 0
			flash[:error] = 'Article does not exist.'
			redirect_to root_path
		else
			@article = Article.find(params[:id])
		end
	end

	def update
		if user_signed_in? and current_user.instructor?
			if params[:id].to_i > Article.all.count or params[:id].to_i < 0
				flash[:error] = 'Article does not exist.'
				redirect_to root_path
			else
				@article = Article.find(params[:id])
		 	
				if @article.update(article_params)
					redirect_to @article
				else
					render 'edit'
				end
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	def destroy
		if params[:id].to_i > Article.all.count or params[:id].to_i < 0
			flash[:error] = 'Article does not exist.'
			redirect_to root_path
		else
			@article = Article.find(params[:id])
			@article.destroy
		 
			redirect_to articles_path
		end
	end
	private
		def article_params
		  params.require(:article).permit(:title, :description, :course_id)
		end
end
