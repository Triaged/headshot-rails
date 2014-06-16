HeadshotRails::Application.routes.draw do
  root :to => "home#index"

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
  	resources :users
    resource :account
    resource :download
    
    namespace :manage do
      resources :users do
        collection do
          get 'import'
        end
      end
      resource :company
    end
  end

  

end