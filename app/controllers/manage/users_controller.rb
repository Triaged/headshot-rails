class Manage::UsersController < ManageController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :resend]

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
      redirect_to manage_users_path, success: 'Contact was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @user.update(user_params)
      redirect_to manage_user_path(@user), success: 'Contact was successfully updated.'
    else
      render :show
    end
  end

  def destroy
    @user.destroy
    redirect_to manage_users_path, success: "#{@user.full_name} was successfully deactivated."
  end

  def resend
    if @user.confirmed_at.nil?
      @user.send_confirmation_instructions
    else
      # send download email
    end
    redirect_to manage_user_path(@user), success: 'Invitation was successfully resent.'
  end

  def archived
    @users = current_company.users.only_deleted
  end

  def restore
    User.restore(params[:id])
    redirect_to manage_users_path, success: 'Contact was successfully activated.'
  end

private

  def set_user
    @user = current_company.users.find(params[:id])
  end

  def user_params
    params[:user].permit(:first_name, :last_name, :email, :department, :employee_info_attributes => [:cell_phone, :office_phone, :job_title, :birth_date, :job_start_date])
  end



end
