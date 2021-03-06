class Company < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name, use: [:slugged, :finders]

	has_many :users
	has_many :imports
	has_many :office_locations
	has_many :departments
	has_one :bamboohr_info

	mount_uploader :logo, CompanyLogoUploader

	after_create :create_default_departments

	validates :name, uniqueness: true

	def should_generate_new_friendly_id?
  	slug.blank? || name_changed?
  end

	def initial
		name[0].capitalize
	end

	def admin_user
		self.users.where(admin: true).first
	end

	def create_default_departments
		Department.create_default_departments self
	end
end
