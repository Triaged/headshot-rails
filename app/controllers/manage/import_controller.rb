class Manage::ImportController < ManageController
	before_action :set_provider, except: :create

	def show
		
	end

	def select
		@import = UserImport.new(@provider.id, current_user.id, current_company.id).import_users
		unless @import.errors.empty?
			logger.info @import.errors.inspect
			flash[:danger] = @import.errors
			redirect_to manage_import_url(@provider.name)
		end
	end

	def create
		import_ids = h["imported_users_attributes"].values.collect {|hash| hash['id'] if hash['should_import'] == "1" }.compact
		UserImport.new(import_params[:provider_id], current_user.id, current_company.id).convert_imported_to_real(import_ids)
	end

private
	def set_provider
		@provider = Provider.find(params[:id])
	end

	def import_params
		params[:import].permit!
	end

end
