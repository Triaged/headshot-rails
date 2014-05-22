class AccountsController < ApplicationController

	def show
		@current_user = current_user
	end

	def edit
		@current_user = current_user
	end

	def update
		if current_user.update(user_params)
      redirect_to root_path, notice: 'Info was successfully updated.'
    else
      render :show
    end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user].permit(:name, :avatar, :employee_info_attributes => [:job_title, :cell_phone, :office_phone, :job_start_date, :birth_date])
  end
end
