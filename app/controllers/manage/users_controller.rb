class Manage::UsersController < ApplicationController

	def index
    @users = current_company.users
  end

  def show
    @user = current_company.users.find(params[:id])
  end

  def import
  	
  end

  def new
  	@user = current_company.users.build
  end



end
