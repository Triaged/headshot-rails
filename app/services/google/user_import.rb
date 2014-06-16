class Google::UserImport


	def initialize user
		@user = user
		@company = @user.company
		google_provider_credentials = @user.provider_credentials.where(provider: Provider.named("google")).first
		
		@client = Google::APIClient.new(application_name: 'Headshot', application_version: '1.0')
		@client.authorization.client_id = ENV['GA_CLIENT_ID']
		@client.authorization.client_secret = ENV['GA_SECRET']
		@client.authorization.update_token!(access_token: google_provider_credentials.access_token, refresh_token: google_provider_credentials.refresh_token)

		@directory = @client.discovered_api('admin', 'directory_v1')
	end

	def fetch_users!
		response = @client.execute(api_method: @directory.users.list, parameters: {'customer' => 'my_customer'})
		
		if response.response.status != 200
			puts response.data.error['errors'].inspect
			return
		end
		

		response.data.users.each do |user|
			email = user.emails.select {|email| email['primary'] == true }.first
			
			u = User.find_or_initialize_by(email: email['address'])
			if u.new_record?
				u.first_name = user['name']['givenName']
				u.last_name = user['name']['lastName']
				u.name = user['name']['fullName']
				u.company_id = @company.id
				u.save
			end
		end
		
	end


end