class Bamboohr::UserImport

	def initialize company
		@bamboohr_info = company.bamboohr_info
		
		@client = BambooHR::Client.new
		@client.subdomain = @bamboohr_info.subdomain
		@client.key = @bamboohr_info.api_key
	end

	def fetch_users!
		employee_list = @client.employee_list
		import = @company.imports.create!(provider: Provider.named("bamboo_hr"))	
		
		employee_list.each do |user|
			puts user.inspect	
		end
		
		Rails.logger.info("import: #{import.inspect}")
		return import
	end


end