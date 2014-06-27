class API::V1::UsersController < APIController
  before_action :set_user, only: [:show, :email_message]

  # GET /api/v1/users
  # GET /api/v1/users.json
  def index
    @users = current_company.users.all
    respond_with @users
  end

  # GET /api/v1/users/1
  # GET /api/v1/users/1.json
  def show
    respond_with @user
  end

  def email_message
    MessageMailer.mobile_message(@user, current_user, email_message_params[:body]).deliver!
    render :json => { "message" => "ok" }, :status => 200
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_company.users.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end

    def email_message_params
      params[:message].permit(:body, :timestamp)
    end
end
