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
	end
	def edit
	end
	def update
	end
	def delete
	end
	private 
		def secure_params
			params[:person].permit(:first_name, :last_name, :book_ids)
		end
end
