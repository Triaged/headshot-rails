class UserImport

	def initialize provider_id, user_id, company_id
		@provider = Provider.find(provider_id)
		@user = User.find(user_id)
		@company = Company.find(company_id)
	end

	def import_users
		Rails.logger.info "Fetching users"
		destroy_existing
		import_class = "#{@provider.name.classify}::UserImport".constantize
		import = import_class.new(@user).fetch_users!
		return import
	end

	def convert_imported_to_real (imported_users)
		imported_users.each { |imported_user| imported_user.convert_to_real! unless imported_user.user_exists? }
		destroy_existing
	end

	def destroy_existing
		@company.imports.destroy_all
	end

end