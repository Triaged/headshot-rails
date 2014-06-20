HeadshotRails::Application.routes.draw do
  root :to => "home#index"

  get 'home/create' => "home#create"
  get 'home/import' => "home#import"
  get 'home/users' => "home#users"
  get 'home/user' => "home#user"
  get 'home/prompt_import' => "home#prompt_import"
  get 'home/profile' => "home#profile"
  get 'home/company' => "home#company"
  get 'home/add' => "home#add"


  # API
  namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
  	namespace :v1 do
      resources :users do
        member do 
          get 'manager'
          get 'subordinates'
        end
      end
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

  # Admin
  devise_for :admins
  namespace :admin, :path => "", :constraints => {:subdomain => "admin"} do
    
  #   resources :users , :controller => 'admin/users'
     resources :companies do
      resources :users
     end
  #   resources :feed_items , :controller => 'admin/feed_items'
  #   resources :messages , :controller => 'admin/messages'
  #   resources :providers, :controller => 'admin/providers'
  #   mount Sidekiq::Web => '/sidekiq'
   end
  
 # Web
  as :user do
      patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
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
end