class API::Internal::UsersController < InternalAPIController
	before_filter :set_user

	def show
		respond_with @user
	end

	def deliver_message
		MessageService.new(@user.id, message_params).deliver
		render :json => { "message" => "ok" }, :status => 200
	end

	def valid_auth_token
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

	def message_params
		params[:message].permit(:author_id, :body, :timestamp)
	end

end
