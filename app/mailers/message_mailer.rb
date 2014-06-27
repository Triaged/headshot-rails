class MessageMailer < ActionMailer::Base
	
  
	def mobile_message recipient, sender, message
		@sender = sender
		@message = message

		mail(to: recipient.email, from: "\"#{@sender.full_name} via Badge\" <team@badge.co>", 
					subject: "#{@sender.full_name} sent you a message")
	end

end
