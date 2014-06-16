class UserImport

	def initialize company_id
		@company = Company.find(company_id)
	end

	def imported_users
		@company.imported_users.all
	end

	def convert_imported_to_real (imported_users)

	end
end