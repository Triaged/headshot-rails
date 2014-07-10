class WipeUserDevices

	def initialize user_id
		@user = User.find(user_id)
	end

	def wipe!
		@user.devices.each {|device| deliver_wipe!(device) }
	end

	def deliver_wipe! device
		puts "Wiping device #{device.inspect}"
		
		notification = Grocer::Notification.new(
			  device_token:      device.token,
			  alert:             nil,
			  sound: 						 nil,
			  badge:             nil,
			  expiry:            Time.now + 60*60*12,     # optional; 0 is default, meaning the message is not stored
			  content_available: true,                  # optional; any truthy value will set 'content-available' to 1
				custom: {
					"WIPE_DEVICE" => true
				}
			)

		GROCER.with do |connection|
  		connection.push(notification)
  		puts "Wiped device #{device.inspect}"
  	end
			

		GROCER_FEEDBACK.each do |attempt|
			puts attempt.inspect
			@device.destroy! if @device
		end
	end
end