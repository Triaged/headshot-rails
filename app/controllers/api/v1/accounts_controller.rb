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
    params[:user].permit(:first_name, :last_name, :avatar, :department_id, :manager_id, :primary_office_location_id,
    	employee_info_attributes: [:job_title, :cell_phone, :office_phone, :job_start_date, :birth_date]
    )
  end

	def set_user
		@user = current_user
	end

end
