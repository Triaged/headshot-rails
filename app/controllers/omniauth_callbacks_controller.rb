class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	
	def google_oauth2
		params = request.env["omniauth.auth"]
		credentials = current_user.save_omniauth("google", params['uid'], params['credentials']['token'], params['credentials']['refresh_token'])
		session[:credentials_id] = credentials.id
		redirect_to select_manage_import_url(id: 'google', subdomain: current_user.company.name)
  end
	
end