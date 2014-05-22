HeadshotRails::Application.routes.draw do
  root :to => "home#index"

  as :user do
      patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => {:registrations => "registrations", omniauth_callbacks: "omniauth_callbacks",  :confirmations => "confirmations"}
  
  namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
  	namespace :v1 do
    	resources :users
  	end
	end
  
  constraints(Subdomain) do
  	resources :users
	end

end