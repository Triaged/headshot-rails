class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	
	def google_oauth2
		params = request.env["omniauth.auth"]
		result = current_user.save_omniauth("google", params['uid'], params['credentials']['token'], params['credentials']['refresh_token'])
    redirect_to root_path
  end
	
	

end