class API::V1::AccountsController < APIController

	def show
		render json: current_user, serializer: AccountSerializer
	end

	def update
		current_user.update(user_params)
		respond_with current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user].permit(:name, :avatar, :employee_info_attributes => [:job_title, :cell_phone, :office_phone, :job_start_date, :birth_date])
  end

end
