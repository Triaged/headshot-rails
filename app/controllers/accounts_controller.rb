class AccountsController < ApplicationController

	def show
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
      redirect_to account_path, success: 'Info was successfully updated.'
    else
      render :show
    end
	end

private
	# Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user].permit(:first_name, :last_name, :email, :department, :employee_info_attributes => [:cell_phone, :office_phone, :job_title, :birth_date, :job_start_date])
  end
end
