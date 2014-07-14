class Sinch::PushService

	def initialize params
		@device = Device.find_by(token: params[:push_token])
		@user = @device.user

		@payload = params[:payload]
		@body = params[:message_body]
		@author = params[:user]
		@can_deliver = true
	rescue
		@can_deliver = false
	end

	def deliver!
		if @can_deliver
			PushService.new(@user.id).deliver(
				"#{@author.first_name.capitalize}: #{@body}".truncate(150),
				increase_badge_count=true,
				custom_payload = { "SIN" => @payload }
			)
		end
	end
end