class FullContactService
	include Rails.application.routes.url_helpers

	def initialize user
		@user = user
	end

	def fetch_results
		puts "fetching"
		puts @user.inspect
		result = FullContact.person(email: @user.email, webhookId: @user.id, webhookUrl: full_contact_index_url)
		puts result
		parse_results result
	end

	def parse_results result
		find_avatar(result["photos"]) if (result.has_key?("photos") && !result["photos"].empty?)
	end

	def find_avatar photos

		# Do a first pass, looking for linkedIn, Gravatar, or Angelist
		photos.each do |photo|
			if photo["type"] == "linkedin" || photo["type"] == "angellist" || photo["type"] == "gravatar"
				puts "updating users avatar"
				@user.update(remote_avatar_url: photos.first["url"])
				return
			end
		end

		@user.update(remote_avatar_url: photos.first["url"])
		return	
	end

end