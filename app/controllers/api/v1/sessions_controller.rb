class Api::V1::SessionsController < API::BaseController
	before_filter :authenticate_user_from_token!, :except => [:create]
	before_filter :authenticate_user!, :except => [:create]
	before_filter :ensure_params_exist
	
	def create
		resource = User.find_for_database_authentication(:email => params[:user_login][:email])
		return invalid_login_attempt unless resource
 		logger.info resource
		if resource.valid_password?(params[:user_login][:password])
			sign_in(:user, resource)
			resource.ensure_authentication_token!
			render json: {authentication_token: resource.authentication_token}
			return
		end
		invalid_login_attempt
	end
	
	def destroy
		current_user.reset_authentication_token
		render :json=> {:success=>true}
	end
 
	protected
	# Only allow a trusted parameter "white list" through.
  def session_params
    params[:user_login].require(:email, :password)
  end

	def ensure_params_exist
		return unless params[:user_login].blank?
		render :json=> "Missing email address", :status=>422
	end
 
	def invalid_login_attempt
		render :json=> "Error with your email or password", :status=>401
	end
end