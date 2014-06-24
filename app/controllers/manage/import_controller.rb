class Manage::ImportController < ManageController
	before_action :set_provider, except: :update

	def show
		
	end

	def select
		crendentials_id = session[:credentials_id]
		@import = UserImport.new(current_user.id, current_company.id).import_users(@provider.id, crendentials_id)
		unless @import.errors.empty?
			flash[:error] = @import.errors
			redirect_to manage_import_url(@provider.name)
		end
	end

	def update
		@import = Import.find(params[:id])

		if @import.update(import_params)
			users = UserImport.new(current_user.id, current_company.id).convert_imported_to_real!(@import)
			redirect_to manage_users_path, success: "#{view_context.pluralize(users.count, 'contact')} successfully imported."
		end
	end

private
	def set_provider
		@provider = Provider.find(params[:id])
	end

	def import_params
		params[:import].permit(:imported_users_attributes => [:id, :should_import])
	end

end
