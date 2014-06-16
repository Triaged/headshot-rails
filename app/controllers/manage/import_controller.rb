class Manage::ImportController < ApplicationController
	before_action :set_provider

	def show
		
	end

	def select
		@import = UserImport.new(@provider.id, current_user.id, current_company.id).import_users
		if @import.errors
			flash[:danger] = @import.errors
			render :show
		end
	end

	def create
		imported_users = []
    UserImport.new(@provider.id, current_user.id, current_company.id).convert_imported_to_real(imported_users)
	end

private
	def set_provider
		@provider = Provider.find(params[:id])
	end

end
