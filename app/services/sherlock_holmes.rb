class SherlockHolmes
	include Sidekiq::Worker

	def perform user_id
		@user = User.find(user_id)
		investigate!
	end

	def investigate!
		puts "investigating"
		FullContactService.new(@user).fetch_results
	rescue
		puts "Sherlock failed"
	end

end

	