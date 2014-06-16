class ImportedUser < ActiveRecord::Base
	belongs_to :company
	belongs_to :import

	def user_exists?
		self.company.users.find(email: self.email)
		true
	rescue
		false
	end

	def convert_to_real!
		self.company.users.create(
			email: self.email,
			first_name: self.first_name,
			last_name: self.last_name,
			full_name: self.full_name
		)
	end

end
