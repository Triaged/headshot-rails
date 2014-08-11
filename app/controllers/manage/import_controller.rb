class Manage::ImportController < ManageController
	before_action :set_provider, except: [:index, :update, :bamboohr, :update_bamboohr_settings]

	def index
		
	end

	def select
		crendentials_id = session[:credentials_id]
		@import = UserImport.new(current_user.id, current_company.id).import_users(@provider.id, crendentials_id)
		unless @import.errors.empty?
			AdminMailer.import_failed(current_user.id).deliver
			flash[:error] = "Authentication failed. Please ensure you are a #{@provider.title} admin and that API access is enabled."
			redirect_to failed_manage_import_path
		end
	end

	def bamboohr
		@bamboohr_info = current_company.bamboohr_info || current_company.build_bamboohr_info
		redirect_to select_manage_import_path(id: Provider.named("bamboohr").id) if @bamboohr_info.info_set?
	end

	def update_bamboohr_settings
		@bamboohr_info = current_company.bamboohr_info || current_company.build_bamboohr_info
		@bamboohr_info.update(bamboohr_info_params)
		
		if @bamboohr_info.valid?
			redirect_to select_manage_import_path(id: Provider.named("bamboohr").id)
		else
			bamboohr_manage_import_index_path
		end
	end

	def failed
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

	def bamboohr_info_params
		params[:bamboohr_info].permit(:api_key, :subdomain)
	end

end
