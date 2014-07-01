class Sinch::PushService

	def initialize params
		@push_token = params[:push_token]
		@payload = params[:payload]
		@body = params[:message_body]
		@device = Device.find_by(token: @push_token)
		@author = params[:user]
	end

	def deliver!
		@device.increment!(:count)
		

		notification = Grocer::Notification.new(
			  device_token:      @push_token,
			  alert:             "#{@author.first_name.capitalize}: #{@body}".truncate(256),
			  sound: 						 'default',
			  badge:             @device.count,
			  expiry:            Time.now + 60*60*12,     # optional; 0 is default, meaning the message is not stored
			  content_available: true,                  # optional; any truthy value will set 'content-available' to 1
				custom: {
					"SIN" => @payload,
				}
			)

		GROCER.with do |connection|
  		connection.push(notification)
  	end
			

		GROCER_FEEDBACK.each do |attempt|
			puts attempt.inspect
		end
	end

	def reset_count!
		@device.update(count: 0)
	end

end