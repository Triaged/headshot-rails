class API::V1::AccountsController < APIController
  skip_before_filter :authenticate_user_from_token!, :only => :reset_password
  skip_before_filter :authenticate_user!, :only => :reset_password
  skip_before_filter :current_company, :only => :reset_password

	before_action :set_user, :except => :reset_password

	def show
		render json: @user, serializer: AccountSerializer
  end

	def update
    @user.update(user_params)
		render json: @user, serializer: AccountSerializer
  end

  def avatar
  	@user.update(user_params)
		render json: @user, serializer: AccountSerializer
  end

  def update_password
    if @user.update_with_password(password_params)
      # Sign in the user by passing validation in case his password changed
      render :json => { "message" => "ok" }, :status => 200
    else
    	render :json=> { "errors" => @user.errors.full_messages }, :status=>401
    end
  end

  def reset_count
    @user.devices.each {|device| device.update(count: 0) }
    render :json => { "message" => "ok" }, :status => 200
  end

  def reset_password
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user.send_reset_password_instructions
      render :json => { "message" => "An email was sent with instructions"}, :status => 200
    else
      render :json => { "message" => "No such email found"}, :status => 200
    end 
    
  end

private

	# Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user].permit(:first_name, :last_name, :avatar, :department_id, :manager_id, :primary_office_location_id, :sharing_office_location,
    	employee_info_attributes: [:job_title, :cell_phone, :office_phone, :job_start_date, :birth_date]
    )
  end

	def set_user
		@user = current_user
	end

	 def password_params
    params[:user].permit(:current_password, :password, :password_confirmation)
  end

end
