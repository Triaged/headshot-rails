class API::V1::AccountsController < APIController
	before_action :set_user, :only => :show

	def show
		render json: @user, serializer: AccountSerializer
	end

	def update
		current_user.update(user_params)
		respond_with current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user].permit(:first_name, :last_name, :avatar, :department_id, :manager_id, :primary_office_location_id
    	employee_info: [:job_title, :cell_phone, :office_phone, :job_start_date, :birth_date],
    	device: [:service, :token, :os_version]
    )
  end

private

	def set_user
		@user = current_user
	end

end
