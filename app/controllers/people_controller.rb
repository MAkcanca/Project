class PeopleController < ApplicationController
  before_filter :authorize_librarian, :except => [:index, :show]
	def index
		@q = Person.ransack(params[:q])
		@people = @q.result(distinct:true)
		@collapse = @people.count != Person.all.count
	end
	def new
	end
	def create
		if user_signed_in? and current_user.librarian? 
			@person = Person.new(secure_params)
			if @person.save
				flash[:notice] = "Successfully created '#{@person.full_name}' as a new author!"
				redirect_to people_path
			else
				flash[:error] = @person.errors.full_messages.to_sentence.humanize
				render 'new'
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	def show
		@person = Person.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
	end

	def edit
		@person = Person.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:error] = 'Record not found.'
			redirect_to root_path
	end

	def update
		if user_signed_in? and current_user.librarian?
			@person = Person.find(params[:id])

			if @person.update(secure_params)
				flash[:notice] = "Successfully updated the person '#{@person.full_name}!'"
			  redirect_to @person
			else
				flash[:error] = @person.errors.full_messages.to_sentence.humanize
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
		if user_signed_in? and current_user.librarian? 
			person = Person.find(params[:id])
			person.books.each do |book|
				if book.people.count == 1
					book.destroy
				end
			end
			flash[:notice] = "Successfully deleted #{person.full_name}!"
			person.destroy
			redirect_to people_path
			rescue ActiveRecord::RecordNotFound
				flash[:error] = 'Record not found.'
				redirect_to root_path
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
	private 
		def secure_params
			params[:person].permit(:first_name, :last_name, :book_ids)
		end
end
