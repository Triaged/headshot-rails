class OfficeLocationService

	def initialize user, office_location
		@user = user
		@office_location = office_location
	end

	def enter!
		@user.update(current_office_location: @office_location)
		#FIREBASE.set("companies/#{@user.company.id}/users/#{@user.id}", current_office_location: @office_location.id)
	end

	def exit!
		@user.update(current_office_location: nil)
		#FIREBASE.delete("companies/#{@user.company.id}/users/#{@user.id}/current_office_location")
	end



end