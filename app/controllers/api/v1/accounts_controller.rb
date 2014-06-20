class API::V1::AccountsController < APIController
	before_action :set_user

	def show
		render json: @user, serializer: AccountSerializer
	end

	def update
		@user.update(user_params)
		render json: @user, serializer: AccountSerializer
  end

  

private

	# Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params = params[:user].permit(:first_name, :last_name, :avatar, :department_id, :manager_id, :primary_office_location_id,
    	employee_info_attributes: [:job_title, :cell_phone, :office_phone, :job_start_date, :birth_date]
    )

    params[:employee_info_attributes][:birth_date] = Date.strptime(params[:employee_info_attributes][:birth_date].to_s, '%s') 
    params[:employee_info_attributes][:job_start_date] = Date.strptime(params[:employee_info_attributes][:job_start_date].to_s, '%s') 

    return params
  end

	def set_user
		@user = current_user
	end

end
