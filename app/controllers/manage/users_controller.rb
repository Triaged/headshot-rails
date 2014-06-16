class Manage::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
    @users = current_company.users
  end

  def show
    @user = current_company.users.find(params[:id])
  end

  def prompt_import
  
  end

  def import
    @users = UserImport.new(current_company.id).imported_users
  end

  def imported
    imported_users = []
    UserImport.new(current_company.id).convert_imported_to_real(imported_users)
  end

  def new
  	@user = current_company.users.build
    @user.build_employee_info
  end

  def create
    @user = current_company.users.new(user_params)

    if @user.save
      redirect_to admin_company_user_path(@company, @user), notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

private

  def set_user
    @user = @company.users.find(params[:id])
  end

  def user_params
    params[:user].permit(:first_name, :last_name, :email, :department, :employee_info_attributes => [:cell_phone, :job_title, :birth_date, :job_start_date])
  end



end
