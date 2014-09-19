class InviteService
	def initialize(invites)
		@invites = invites
	end

	def deliver
		@invites.each do |invite|
			email = invite['email']
			if not email.to_s.length == 0
				InviteMailer.invite( email ).deliver
			end
		end
	end
end

