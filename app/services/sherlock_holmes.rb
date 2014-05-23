class SherlockHolmes

	def initialize user_id
		@user = User.find(user_id)
	end

	def investigate!
		puts "investigating"
		person = FullContact.person(email: @user.email)
		puts person.inspect
	end

end

	