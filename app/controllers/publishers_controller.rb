class PublishersController < ApplicationController
	before_filter :authorize_initialized, :except => [:index, :show]
	def index
		@q = Publisher.ransack(params[:q])
		@publishers = @q.result(distinct:true)
		@collapse = @publishers.count != Publisher.all.count
	end
	def new
	end
	def create
		if user_signed_in? and current_user.librarian?
			@publisher = Publisher.new(secure_params)
			if @publisher.save
				flash[:notice] = 'Publisher created!'
				redirect_to @publisher
			else
				flash[:error] = @publisher.errors.full_messages.to_sentence.humanize
				render 'new'
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	def edit
		@publisher = Publisher.find(params[:id])
	end
	def update
		if user_signed_in? and current_user.librarian?
			@publisher = Publisher.find(params[:id])
			if @publisher.update(secure_params)
				flash[:notice] = "Successfully updated the publisher '#{@publisher.title}!'"
				redirect_to @publisher
			else
				flash[:error] = @publisher.errors.full_messages.to_sentence.humanize
				render 'edit'
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end

	def show
		@publisher = Publisher.find(params[:id])
	end

	def destroy
		@publisher = Publisher.find(params[:id])
		if user_signed_in? and current_user.librarian?
			@publisher.books.each do |book|
				book.update_attribute(publisher_id,0)
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	private
		def secure_params
		  params[:publisher].permit(:title)
		end
end
