class API::Internal::UsersController < InternalAPIController
	before_filter :set_user

	def show
		respond_with @user
	end

	def deliver_message
	end

	def valid_auth_token
		if @user == User.find_by(authentication_token: params[:authentication_token])
			render :json => { "success" => "true" }, :status => 200
		else
			render :json => { "success" => "true" }, :status => 200
		end
	rescue
		render :json => { "success" => "true" }, :status => 200
	end

private

	def set_user
		@user = User.find(params[:id])
	end

end
