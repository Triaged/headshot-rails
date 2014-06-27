# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview

	def mobile_message
    MessageMailer.mobile_message(User.first, User.last, "This is a test")
  end

end
