class MessageMailer < ActionMailer::Base
	include Sidekiq::Mailer
  
	def mobile_message recipient_id, sender_id, message
		@recipient = User.find(recipient_id)
		@sender = User.find(sender_id)
		@message = message
		@token = Devise.token_generator.digest(self, :confirmation_token, @recipient.confirmation_token)

		mail(to: @recipient.email, from: "\"#{@sender.full_name} via Badge\" <team@badge.co>", 
					subject: "#{@sender.full_name} sent you a message")
	end

end
