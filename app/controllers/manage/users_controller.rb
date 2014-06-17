class Manage::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
    @users = current_company.users
  end

  def show
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
    @user = current_company.users.find(params[:id])
  end

  def user_params
    params[:user].permit(:first_name, :last_name, :email, :department, :employee_info_attributes => [:cell_phone, :job_title, :birth_date, :job_start_date])
  end



end
