class OfficeLocationService

	def initialize user, office_location
		@user = user
		@office_location = office_location
	end

	def enter!
		@user.update(current_office_location: @office_location)
	end

	def exit!
		@user.update(current_office_location: nil)
	end



end