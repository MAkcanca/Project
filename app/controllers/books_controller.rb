class BooksController < ApplicationController
  before_filter :authorize_student_or_librarian, :except => [:index, :show]

  def index
		@q = Book.ransack(params[:q])
		@books = @q.result(distinct:true)
		@collapse = @books.count != Book.all.count
  end

  def show
		@book = Book.find(params[:id])
  end

  def new
  end

	def create
		if user_signed_in? and current_user.librarian?
			@book = Book.new(secure_params)
			if @book.pages == 0
				flash[:error] = 'Invalid page number.'
				render 'new'
			elsif not (is_number? @book.isbn)
				flash[:error] = 'Invalid ISBN.'
				render 'new'
			else
				publish_date = Date.civil(params[:publish_date][:year].to_i, params[:publish_date][:month].to_i, params[:publish_date][:day].to_i)
				@book.update_attributes(:publish_date => publish_date)
				if @book.save
					flash[:notice] = "Book created!"
					redirect_to @book
				else
					flash[:error] = @book.errors.full_messages.to_sentence.humanize
					render 'new'
				end
			end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		if user_signed_in? and current_user.librarian?
			@book = Book.find(params[:id])

		  if @book.update(secure_params)
				flash[:notice] = "Successfully updated the book '#{@book.title}!'"
		    redirect_to @book
		  else
				flash[:error] = @book.errors.full_messages.to_sentence.humanize
		    render 'edit'
		  end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
	end
 	def destroy
		if user_signed_in? and current_user.librarian? 
		  book = Book.find(params[:id])
		  book.destroy
		  redirect_to books_path
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path
		end
  end

	def reserve
		@book = Book.find(params[:book])
		if user_signed_in? and current_user.student?
			@book.user_ids = @book.user_ids << current_user.id
			@book.save!
			respond_to do |format|
	      format.html {redirect_to book_path(@book.id) }
	      format.js
	    end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end

	def unreserve
		@book = Book.find(params[:book])
		if user_signed_in? and current_user.student?
			current_user.book_ids = current_user.book_ids - [@book.id]
			@book.user_ids = @book.user_ids - [current_user.id]
			@book.save!
			respond_to do |format|
	      format.html {redirect_to book_path(@book.id) }
	      format.js
	    end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end
	
	def checkout
		@book = Book.find(params[:book])
		if user_signed_in? and current_user.librarian? and not @book.nil? and not @book.users.nil? and not @book.users.empty?
			user = @book.users.first
			
			@book.update_attributes(:due_date => Date.today + 7.days, :holder_id => user.id)
			@book.save!
			respond_to do |format|
	      format.html {redirect_to book_path(@book.id) }
	      format.js
	    end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end

	def uncheckout
		@book = Book.find(params[:book])
		if user_signed_in? and current_user.librarian? and not (@book.holder_id.nil?)
			user = User.find(@book.holder_id)
			user.book_ids = user.book_ids - [@book.id]

			@book.user_ids = @book.user_ids - [user.id]
			@book.holder_id = nil
			@book.due_date = nil
			@book.save!
			respond_to do |format|
	      format.html {redirect_to book_path(@book.id) }
	      format.js
	    end
		else
			flash[:error] = 'Access denied.'
			redirect_to root_path 
		end
	end
	def renew
		@book = Book.find(params[:book])
		if user_signed_in? and current_user.student? and @book.holder_id == current_user.id and not @book.renewed 
			@book.renewed = true
			if Date.today >= @book.due_date
				@book.update_attributes(:due_date => Date.today + 7.days)
			else
				@book.update_attributes(:due_date => @book.due_date + 7.days)
			end
			@book.save!
			respond_to do |format|
	      format.html {redirect_to book_path(@book.id) }
	      format.js
	    end
		end
	end
	private
		def secure_params
		  params[:book].permit(:title,:author,:description,:pages,:isbn,:publisher,:publish_date,:category_id)
		end
end
