class ImportedUser < ActiveRecord::Base
	belongs_to :company

	def user_exists?
		self.company.users.find(email: self.email)
		true
	rescue
		false
	end

	# def convert_to_real
	# 	self.company.users.create
	# end

end
