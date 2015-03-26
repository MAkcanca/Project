Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :controllers => {registrations: 'registrations'}

  resources :users do
		collection {post :search, to: 'users#index'}
	end
  resources :courses do
		collection {post :search, to: 'courses#index'}
	end
	resources :icons
	resources :uploads, :only => [:new, :create, :show, :destroy]
	resources :grades
	resources :folders
	resources :articles
	resources :semesters
	resources :books do
		collection {post :search, to: 'books#index'}
	end
	resources :uploads

  get '/enroll' => 'courses#enroll', :as => :enroll
  get '/drop' => 'courses#drop', :as => :drop
	get '/reserve' => 'books#reserve', :as => :reserve
	get '/unreserve' => 'books#unreserve', :as => :unreserve
	get '/checkout' => 'books#checkout', :as => :checkout
	get '/uncheckout' => 'books#uncheckout', :as => :uncheckout
	get '/renew' => 'books#renew', :as => :renew
end
