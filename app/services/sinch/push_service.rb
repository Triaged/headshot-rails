class Sinch::PushService

	def initialize params
		@push_token = params[:push_token]
		@payload = params[:payload]
		@body = params[:message_body]
		@device = Device.find_by(token: @push_token)
		@author = params[:user]
	end

	def deliver!
		puts "Pushing to #{@push_token}"
		@device.increment!(:count) if @device
		

		notification = Grocer::Notification.new(
			  device_token:      @push_token,
			  alert:             "#{@author.first_name.capitalize}: #{@body}".truncate(150),
			  sound: 						 'default',
			  badge:             (@device ? @device.count : 1),
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
			@device.destroy! if @device
		end
	end

	def reset_count!
		@device.update(count: 0)
	end

end