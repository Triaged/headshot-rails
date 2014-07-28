class Admin::UsersController < AdminController
	before_action :set_company
	before_action :set_user, only: [:show, :edit, :update, :destroy, :invite]

	def index
		@users = @company.users.all
	end

	def show 

	end

	def become
    sign_in(:user, @company.users.find(params[:id]))
    redirect_to root_url # or user_root_url
  end

  def invite
  	@user.send_confirmation_instructions
  	redirect_to admin_company_path(@company), notice: 'User was successfully invited.'
  end

	def new
		@user = @company.users.build
	end

	def create
		@user = @company.users.new(user_params)
		logger.info params[:send_confirmation]
		@user.skip_confirmation_notification! unless params[:send_confirmation]

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

	def set_company
		@company = Company.find(params[:company_id])
	end

	def user_params
		params[:user].permit(:first_name, :last_name, :email, :admin)
	end

end
