class OfficeLocationService

	def initialize user, office_location
		@user = user
		@office_location = office_location
	end

	def enter!
		@user.update(current_office_location: @office_location)
		user_ref = FIREBASE.child("companies/#{@user.company.id}/users/#{@user.id}")
		user_ref.child('current_office_location').set("#{@office_location.id}")
	end

	def exit!
		@user.update(current_office_location: nil)
		user_ref = FIREBASE.child("companies/#{@user.company.id}/users/#{@user.id}")
		user_ref.delete('current_office_location')
	end



end