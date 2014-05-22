class API::V1::UsersController < APIController
  before_action :set_user, only: [:show]

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

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @api_v1_user = current_company.users.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
