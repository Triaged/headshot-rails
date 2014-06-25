class SherlockHolmes
	include Sidekiq::Worker

	def perform user_id
		@user = User.find(user_id)
		investigate!
	end

	def investigate!
		puts "investigating"
		person = FullContact.person(email: @user.email)
		puts person.inspect
	rescue
		puts "Sherlock failed"
	end
end

	