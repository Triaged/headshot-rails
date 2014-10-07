class API::V1::AuthenticationsController < APIController

	skip_before_filter :authenticate_user_from_token!
	skip_before_filter :authenticate_user!
	skip_before_filter :current_company

	def create
		@user = User.find_by( email: auth_params[:email] )

		unless @user
			@user = User.new( auth_params )
			@user.skip_confirmation_notification!
			@user.save
		end

		AuthenticationService.new(@user).generate_and_deliver!

		render :json => { "id" => @user.id }, :status => 200

	end

	def valid
		@user = User.find_by( id: auth_params[:id].to_i, challenge_code: auth_params[:challenge_code]  )
		if @user
			@user.ensure_authentication_token!
			render json: @user, serializer: AccountSerializer
		else
			render :json=> {}, :status=>401
		end
	end

	def auth_params
		params[:auth_params].permit( :first_name, :last_name, :email, :phone_number, :id, :challenge_code )
	end

end
