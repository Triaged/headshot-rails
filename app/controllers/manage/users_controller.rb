class Manage::UsersController < ManageController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :resend, :wipe_devices, :make_admin]
  before_action :require_admin, only: [:make_admin]

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

  def wipe_devices
    WipeUserDevices.new(@user).wipe!
    redirect_to manage_user_path(@user), success: 'Devices successfully wiped.'
  end

  def resend
    if @user.confirmed_at.nil?
      @user.send_confirmation_instructions
    else
      # send download email
    end
    redirect_to manage_user_path(@user), success: 'Invitation was successfully resent.'
  end

  def invite_all
    current_company.users.where(confirmed_at: nil).all.each do |user|
      user.send_confirmation_instructions
    end
    redirect_to manage_users_path(@user), notice: 'All Users invited.'  
  end

  def make_admin
    @user.update(admin: true)
    redirect_to manage_user_path(@user), success: "#{@user.first_name} is now an admin."
  end

  def archived
    @users = current_company.users.only_deleted
  end

  def restore
    User.restore(params[:id])
    redirect_to manage_users_path, success: 'Contact was successfully activated.'
  end

private

  def require_admin
    redirect_to manage_users_path and return unless current_user.admin
  end

  def set_user
    @user = current_company.users.with_deleted.friendly.find(params[:id])
  end

  def user_params
    params[:user].permit(:first_name, :last_name, :email, :department_id, :manager_id, :employee_info_attributes => [:cell_phone, :office_phone, :job_title, :birth_date, :job_start_date])
  end



end
