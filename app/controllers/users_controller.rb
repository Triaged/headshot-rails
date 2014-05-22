class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = current_company.users
  end

  def show
    @user = current_company.users.find(params[:id])
  end

end
