class UserImport

	def initialize user_id, company_id
		@user = User.find(user_id)
		@company = Company.find(company_id)
	end

	def import_users provider_id
		provider = Provider.find(provider_id)
		destroy_existing
		
		import_class = "#{provider.name.classify}::UserImport".constantize
		import = import_class.new(@user).fetch_users!
		return import
	end

	def convert_imported_to_real (import)
		import.imported_users.each do |imported_user|
			imported_user.convert_to_real! if (imported_user.should_import && !imported_user.user_exists?)
		end
		destroy_existing
	end

	def destroy_existing
		@company.imports.destroy_all
	end

end