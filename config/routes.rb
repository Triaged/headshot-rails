require 'sidekiq/web'
HeadshotRails::Application.routes.draw do
  root :to => "home#index"

  # API
  namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
  	namespace :v1 do
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
	end

 
  
 # Web
  as :user do
      patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users/:id' => 'devise/registrations#update', :as => 'user_registration' 
  end
  devise_for :users, :skip => [:registrations], :controllers => {omniauth_callbacks: "omniauth_callbacks",  :confirmations => "confirmations"}
  
  constraints(Subdomain) do
  	resource :account
    resource :download do
      post 'txt', on: :member
    end
    
    namespace :manage do
      resources :users do
        collection do
          get 'archived'
        end
        member do
          post 'restore'
          put 'resend'
          post 'wipe_devices'
        end
      end
      resources :import do
        member do
          get 'select'

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
      end
     end
    
  end

  mount Sidekiq::Web => '/sidekiq'
end