class ImportedUser < ActiveRecord::Base
	belongs_to :company
	belongs_to :import

	has_one :employee_info

	mount_uploader :avatar, AvatarUploader

	before_create :build_employee_info

	def user_exists?
		User.exists?(email: self.email)
	end

	def convert_to_real!
		logger.info self.inspect

		user = self.company.users.create(
			email: self.email,
			first_name: self.first_name,
			last_name: self.last_name,
		)

		user.employee_info = self.employee_info
		user.department = Department.find_or_create_by(name: self.department) if self.department
		user.avatar = self.avatar if self.avatar?
		user.save

		return user
	end

end
