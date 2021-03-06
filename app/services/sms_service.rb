class SmsService
	

	def initialize(phone_number)
		@phone_number = phone_number
	end

	def deliver!
		TWILIO_CLIENT.account.sms.messages.create(
      :from => ENV["TWILIO_FROM_NUMBER"],
      :to => @phone_number,
      :body => default_delivery_message
    )
		true
  rescue Twilio::REST::RequestError 
  	false
	end

	def default_delivery_message
		"Download Badge here - bit.ly/1o0rs9I"
	end

end