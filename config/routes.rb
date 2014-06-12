HeadshotRails::Application.routes.draw do
  root :to => "home#index"

  as :user do
      patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => {:registrations => "registrations", omniauth_callbacks: "omniauth_callbacks",  :confirmations => "confirmations"}
  
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
  
  constraints(Subdomain) do
  	resources :users
    resource :account
    resource :download
    
    namespace :admin do
      resources :users do
        collection do
          get 'import'
        end
      end
    end
    
	end

end