class MessageMailer < ActionMailer::Base
	include Sidekiq::Mailer
  
	def mobile_message recipient_id, sender_id, message
		@recipient = User.find(recipient_id)
		@sender = User.find(sender_id)
		@message = message
		unless @recipient.confirmed?
			@token, secure_token = Devise.token_generator.generate(User, :confirmation_token)
   		@recipient.update_attributes(confirmation_token: secure_token)
		end
		

		mail(to: @recipient.email, from: "\"#{@sender.full_name} via Badge\" <team@badge.co>", 
					subject: "#{@sender.full_name} sent you a message")
	end

end
