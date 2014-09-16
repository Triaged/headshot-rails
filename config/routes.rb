require 'sidekiq/web'
HeadshotRails::Application.routes.draw do
	root :to => "home#index"
	match '/about' => "home#about", :via => :get
	match '/faq' => "home#faq", :via => :get
	match '/signup' => "home#signup", :via => :post
	match '/campaigns' => "home#campaigns", :via => :get
	match '/construction' => "home#construction", :via => :get
	match '/events' => "home#events", :via => :get
	match '/hospitality' => "home#hospitality", :via => :get
	match '/retail' => "home#retail", :via => :get

	# API
	namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
		namespace :v1 do
			resource :authentications
			resource :versions do
				get 'ios', on: :member
				get 'android', on: :member
			end
			resources :users do
				post 'email_message', on: :member
			end
			resources :office_locations do
				member do
					put 'entered'
					put 'exited'
				end
			end
			resources :devices, only: :create do
				delete 'sign_out', on: :member
			end

			resources :departments
			resource :account do
				member do
					post 'avatar'
					put 'update_password'
					post 'reset_count'
					post 'reset_password'
				end
			end
			resource :company
			resource :push_services, only: :create
			devise_scope :user do
				match '/sessions' => 'sessions#create', :via => :post
				match '/sessions' => 'sessions#destroy', :via => :delete
				match '/registrations' => 'registrations#create', :via => :post
			end
		end

		# Internal API, never to be exposed to public
		namespace :internal do
			resources :users do
				member do
					get 'valid_auth_token'
					post 'deliver_message'
					get 'in_group'
				end
			end
		end
	end



	# Web
	as :user do
		put '/users/password' => 'devise/passwords#update'
		patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
		get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
		put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
	end
	devise_for :users, :skip => [:registrations], :controllers => {omniauth_callbacks: "omniauth_callbacks",  :confirmations => "confirmations"}

	constraints(Subdomain) do
		resource :account
		resource :download do
			post 'txt', on: :member
			post 'txt_stored', on: :member
		end

		namespace :manage do
			resources :users do
				collection do
					get 'archived'
					post 'invite_all'
				end
				member do
					post 'restore'
					put 'resend'
					post 'wipe_devices'
					post 'make_admin'
				end
			end
			resources :import do
				member do
					get 'select'
					get 'failed'

				end
				get 'bamboohr', on: :collection
				post 'update_bamboohr_settings', on: :collection
			end
			resource :company
			resources :office_locations
			resources :departments
		end
	end

	resources :full_contact, only: :create
	resource :beta_distribution, only: :show

	# Admin
	devise_for :admins
	namespace :admin, :path => "", :constraints => {:subdomain => "admin"} do
		resources :companies do
			resources :users do
				post 'become', on: :member
				post 'invite', on: :member
				delete 'destroy_all', on: :collection
				post 'invite_all', on: :collection
			end
			resources :office_locations
			resources :departments
		end
		resources :pilots

	end

	mount Sidekiq::Web => '/sidekiq'
end
