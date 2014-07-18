class Bamboohr::UserImport

	def initialize user, credentials
		@company = user.company
		@bamboohr_info = @company.bamboohr_info
		
		@client = BambooHR::Client.new
		@client.subdomain = @bamboohr_info.subdomain
		@client.key = @bamboohr_info.api_key
	end

	def fetch_users!
		response = @client.employee_list
		import = @company.imports.create!(provider: Provider.named("bamboo_hr"))	
		
		response["employees"].each do |user|
			email = user["workEmail"]
			
			if email && User.with_deleted.where(email: email).count < 1
				imported_user = import.imported_users.find_or_initialize_by(email: email)
				imported_user.company = @company
				imported_user.first_name = user['firstName']
				imported_user.last_name = user['lastName']
				imported_user.department = user['department']
				imported_user.location = user['location']
				imported_user.avatar_url = user['photoUrl'] if user['photoUploaded']

				imported_user.build_employee_info
				imported_user.employee_info.job_title = user['jobTitle']
				imported_user.employee_info.office_phone = user['workPhone']
				imported_user.employee_info.cell_phone = user['mobilePhone']
				
				imported_user.save
			else
				Rails.logger.info "User #{email} exists"
			end
		end
		
		Rails.logger.info("import: #{import.inspect}")
		return import
	end


end