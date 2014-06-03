class Sinch::PushService

	def init (push_token, payload)
		@push_token = push_token
		@payload = payload
	end

	def deliver!
		Rails.logger.info @push_token
		Rails.logger.info @payload

		notification = Grocer::Notification.new(
			  device_token:      @push_token,
			  alert:             'incoming message',
			  sound: 						 'default',
			  badge:             1,
			  expiry:            Time.now + 60*60*12,     # optional; 0 is default, meaning the message is not stored
			  content_available: true,                  # optional; any truthy value will set 'content-available' to 1
				custom: {
					"SIN" => @payload
				}
			)
	end

end