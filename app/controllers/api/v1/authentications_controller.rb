class API::V1::AuthenticationsController < APIController

	skip_before_filter :authenticate_user_from_token!
	skip_before_filter :authenticate_user!
	skip_before_filter :current_company

	def create
		@user = User.find_by( email: auth_params[:email] ) \
			|| User.find_by( phone_number: auth_params[:phone_number] )

		unless @user
			@user = User.new( auth_params )
			@user.skip_confirmation_notification!
			@user.save
		end

		AuthenticationService.new(@user).generate_and_deliver!

		render :json => { "id" => @user.id }, :status => 200

	end

	def valid
	end

	def auth_params
		params[:auth_params].permit( :first_name, :last_name, :email, :phone_number )
	end

end
