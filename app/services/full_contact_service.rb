class FullContactService
	include Rails.application.routes.url_helpers

	MIN_LIKELIHOOD = 0.85

	def initialize user
		@user = user
	end

	def fetch_results
		result = FullContact.person(email: @user.email, webhookId: @user.id, webhookUrl: full_contact_index_url)
		parse_results result unless result["likelihood"] < MIN_LIKELIHOOD)
	end

	def parse_results result
		find_avatar(result["photos"]) if (result.has_key?("photos") && !result["photos"].empty?)
	end

	def find_avatar photos

		# Do a first pass, looking for linkedIn, Gravatar, or Angelist
		photos.each do |photo|
			if photo["type"] == "linkedin" || photo["type"] == "angellist" || photo["type"] == "gravatar"
				@user.update(remote_avatar_url: photo["url"]) unless @user.avatar?
				return
			end
		end

		@user.update(remote_avatar_url: photos.first["url"]) unless @user.avatar?
		return	
	end

end