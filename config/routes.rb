Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :controllers => {registrations: 'registrations'}

  resources :users do
		collection {post :search, to: 'users#index'}
	end
  resources :courses do
		collection {post :search, to: 'courses#index'}
	end
	resources :books do
		collection {post :search, to: 'books#index'}
	end
	resources :people do
		collection {post :search, to: 'people#index'}
	end
	resources :publishers do
		collection {post :search, to: 'publishers#index' }
	end
	resources :icons
	resources :uploads, :only => [:new, :create, :show, :destroy]
	resources :grades
	resources :folders
	resources :articles
	resources :semesters
	resources :uploads
	resources :departments
	resources :homes
	resources :avatars


  get '/enroll' => 'courses#enroll', :as => :enroll
  get '/drop' => 'courses#drop', :as => :drop
	get '/remove' => 'courses#remove', :as => :remove

	get '/reserve' => 'books#reserve', :as => :reserve
	get '/unreserve' => 'books#unreserve', :as => :unreserve
	get '/checkout' => 'books#checkout', :as => :checkout
	get '/uncheckout' => 'books#uncheckout', :as => :uncheckout
	get '/renew' => 'books#renew', :as => :renew
	get '/noauthor' => 'books#noauthor', :as => :noauthor
	get '/newauthor' => 'books#newauthor', :as => :newauthor
	post '/createnewauthor' => 'books#createnewauthor', :as => :createnewauthor
end
