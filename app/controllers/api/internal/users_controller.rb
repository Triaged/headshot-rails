class API::Internal::UsersController < InternalAPIController
	before_filter :set_user

	def show
		respond_with @user
	end

	def deliver_message
	end

	def valid_auth_token
		logger.info @user.id
		logger.info User.find_by(authentication_token: params[:authentication_token]).id
		if @user.id == User.find_by(authentication_token: params[:authentication_token]).id
			render :json => { "success" => "true" }, :status => 200
		else
			render :json => { "success" => "false" }, :status => 200
		end
	rescue
		render :json => { "success" => "false" }, :status => 200
	end

private

	def set_user
		@user = User.find(params[:id])
	end

end
