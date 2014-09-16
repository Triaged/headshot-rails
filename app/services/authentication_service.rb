class AuthenticationService

	def initialize(user)
		@user = user
	end

	def generate
		token = generate_activation_code
		@user.update_attribute( :challenge_code, token )
	end

	def deliver!
		AuthenticationMailer.challenge(@user.id).deliver
	end

	def generate_and_deliver!
		generate
		deliver!
	end

end

def generate_activation_code(size = 4)
	charset = %w{1 2 3 4  5 6 7 8 9 }
	(0...size).map{ charset.to_a[rand(charset.size)] }.join
end
