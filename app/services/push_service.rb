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

	def deliver_message author, message, thread_id
		@devices.each do |device|
			if device.service == "ios"
				alert = "#{author.first_name.capitalize}: #{message}"
				deliver_to_apns(device, alert, true, {thread_id: thread_id}) if device.logged_in
			else
				alert = message
				deliver_to_google_cloud(device, alert, true, {thread_id: thread_id, author_name: author.first_name}) if device.logged_in
			end
		end
	end

	# def deliver_to_apns device, alert, increase_badge_count, custom_payload
	# 	puts "Pushing to #{device.inspect}"
	# 	device.increment!(:count) if increase_badge_count
		

	# 	notification = Grocer::Notification.new(
	# 		  device_token:      device.token,
	# 		  alert:             alert,
	# 		  sound: 						 'default',
	# 		  badge:             (increase_badge_count ? device.count : nil),
	# 		  expiry:            Time.now + 60*60*12,     # optional; 0 is default, meaning the message is not stored
	# 		  content_available: true,                  # optional; any truthy value will set 'content-available' to 1
	# 			custom: custom_payload
	# 		)

	# 	GROCER.with do |connection|
 #  		connection.push(notification)
 #  		puts "Pushed msg"
 #  	end
			

	# 	GROCER_FEEDBACK.each do |attempt|
	# 		puts "Push failed"
	# 		puts attempt.inspect
	# 		device.destroy! if device
	# 	end
	# end

	def deliver_to_apns device, alert, increase_badge_count, custom_payload
		device.increment!(:count) if increase_badge_count

		client = AWS::SNS::Client.new
		apns_payload = { 
			"aps" => { 
				"alert" => alert.truncate(80), 
				"badge" => (increase_badge_count ? device.count : 0),
				"content_available" => true,
				"expiry" => Time.now + 60*60*12,
				"sound" => "default"
			}
		}.merge(custom_payload).to_json
		message = { "default" => "New Badge Message", "APNS" => apns_payload }.to_json

		client.publish( message: message, target_arn: device.arn, message_structure: 'json' )
	rescue
		Rails.logger.info "delivery to device: #{device.inspect} failed"
		device.delete_sns_endpoint
		device.destroy
	end

	def deliver_to_google_cloud device, alert, increase_badge_count, custom_payload
		client = AWS::SNS::Client.new
		
		gcm_payload = {data: {message: alert}.merge(custom_payload), collapse_key: "message"}.to_json
		message = { "default" => alert, "GCM" => gcm_payload }.to_json
		
		client.publish( message: message, target_arn: device.arn, message_structure: 'json' )
	rescue
		Rails.logger.info "delivery to device: #{device.inspect} failed"
		device.delete_sns_endpoint
		device.destroy
	end
	
	# def deliver_to_google_cloud device, alert, increase_badge_count, custom_payload
	# 	registration_ids= [device.token]
		
	# 	response = GOOGLE_CM.send_notification(registration_ids, options)
	# end


end