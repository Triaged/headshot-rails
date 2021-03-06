class Google::UserImport


	def initialize user, credentials
		@user = user
		@company = @user.company
		google_provider_credentials = credentials
		
		@client = Google::APIClient.new(application_name: 'Badge', application_version: '1.0')
		@client.authorization.client_id = ENV['GA_CLIENT_ID']
		@client.authorization.client_secret = ENV['GA_SECRET']
		@client.authorization.update_token!(access_token: google_provider_credentials.access_token, refresh_token: google_provider_credentials.refresh_token)

		@directory = @client.discovered_api('admin', 'directory_v1')
	end

	def fetch_users!
		response = @client.execute(api_method: @directory.users.list, parameters: {'customer' => 'my_customer'})
		import = @company.imports.create!(provider: Provider.named("google"))	
		
		if response.response.status != 200
			puts response.data.error['errors'].inspect
			import.errors[:base] << "Import Failed"
			return import
		end
		
		response.data.users.each do |user|
			email = user.emails.select {|email| email['primary'] == true }.first
			
			if User.with_deleted.where(email: email['address']).count < 1
				imported_user = import.imported_users.find_or_initialize_by(email: email['address'])
				imported_user.company = @company
				imported_user.first_name = user['name']['givenName']
				imported_user.last_name = user['name']['familyName']
				imported_user.full_name = user['name']['fullName']
				#imported_user.avatar = fetch_avatar_data user['id']
				imported_user.save
			else
				Rails.logger.info "User #{email['address']} exists"
			end
		end
		Rails.logger.info("import: #{import.inspect}")
		return import
	end

	def fetch_avatar_data id
		response = @client.execute(api_method: @directory.users.photos.get, parameters: {'userKey' => id})
		avatar_data = response.data["photoData"]
		s = StringIO.new(avatar_data)
		def s.original_filename; "#{id}.png"; end
		return s
	end
end