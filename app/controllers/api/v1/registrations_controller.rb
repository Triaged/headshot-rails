class API::V1::RegistrationsController < APIController

	skip_before_filter :authenticate_user_from_token!
	skip_before_filter :authenticate_user!
	skip_before_filter :current_company
	
	def create
		user = User.find_or_initialize_by(email: registration_params[:email])

		# Merge params if this is a new user or an unregistered user
		if user.new_record?
			user.assign_attributes(registration_params.merge(registered: true))
		end

		# Check if this user can be saved.
		if user.save
			sign_in(:user, user)
			user.ensure_authentication_token!
			render json: user, serializer: AccountSerializer
			return
		else
			warden.custom_failure!
			render :json=> error_message(user.errors.first), :status=>422
		end
	end

private
	def registration_params
    params[:registration].permit(:email, :phone_number, :password, :first_name, :last_name)
  end

  def error_message message_hash
  	message_hash.join(" ")
  end
end

# user = find_or_initalize by email
# if user.new_record? or !user.registered
	# set params

# if user.save

# else
