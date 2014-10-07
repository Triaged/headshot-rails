class InviteService
	def initialize(invites)
		@invites = invites
	end

	def deliver
		@invites.each do |invite|
			email = invite['email']
			phone = invite['phone']
			if email.to_s.length != 0
				InviteMailer.invite( email ).deliver
			elsif phone.to_s.length != 0
				SmsService.new(phone).deliver!("You've been invited to try out the Badge Application!")
			end
		end
	end
end

