class PushService

	def initialize user_id
		@user = User.find(user_id)
		@devices = @user.devices.to_a.uniq{ |device| device.token }
	end

	def deliver alert, increase_badge_count=false, custom_payload=nil
		@devices.each do |device|
			if device.service == "ios"
				deliver_to_apns device, alert, increase_badge_count, custom_payload if device.logged_in
			else
				deliver_to_google_cloud device, alert, increase_badge_count, custom_payload if device.logged_in
			end
		end
	end

	def deliver_to_apns device, alert, increase_badge_count, custom_payload
		puts "Pushing to #{device.inspect}"
		device.increment!(:count) if increase_badge_count
		

		notification = Grocer::Notification.new(
			  device_token:      device.token,
			  alert:             alert,
			  sound: 						 'default',
			  badge:             (increase_badge_count ? device.count : nil),
			  expiry:            Time.now + 60*60*12,     # optional; 0 is default, meaning the message is not stored
			  content_available: true,                  # optional; any truthy value will set 'content-available' to 1
				custom: custom_payload
			)

		GROCER.with do |connection|
  		connection.push(notification)
  		puts "Pushed msg"
  	end
			

		GROCER_FEEDBACK.each do |attempt|
			puts "Push failed"
			puts attempt.inspect
			device.destroy! if device
		end
	end

	def deliver_to_google_cloud device, alert, increase_badge_count, custom_payload
		registration_ids= [device.token]
		options = {data: {message: alert}, collapse_key: "message"}
		response = GOOGLE_CM.send_notification(registration_ids, options)
	end


end