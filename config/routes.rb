HeadshotRails::Application.routes.draw do
  root :to => "home#index"

  # API
  namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
  	namespace :v1 do
      resources :users
      resources :office_locations do
        member do 
          post 'entered'
          delete 'exited'
        end
      end
      resources :devices, only: :create
      resources :departments
      resource :account
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
    resource :download
    
    namespace :manage do
      resources :users do
        collection do
          get 'archived'
        end
        member do
          post 'restore'
          put 'resend'
        end
      end
      resources :import do
        member do
          get 'select'
        end
      end
      resource :company
      resources :office_locations
      resources :departments
    end
  end

   # Admin
  devise_for :admins
  namespace :admin, :path => "", :constraints => {:subdomain => "admin"} do
     resources :companies do
      resources :users
     end
  end
end