class ImportedUser < ActiveRecord::Base
	belongs_to :company
	belongs_to :import

	def user_exists?
		User.exists?(email: self.email)
	end

	def convert_to_real!
		user = self.company.users.create(
			email: self.email,
			first_name: self.first_name,
			last_name: self.last_name,
		)
		Rails.logger.info user.inspect
		Rails.logger.info user.errors.inspect
	end

end
