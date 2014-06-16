class Company < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name, use: [:slugged, :finders]

	has_many :users
	has_many :imports
	has_many :office_locations
	has_many :departments

	after_create :create_default_departments

	def create_default_departments
		Department.create_default_departments self
	end

end
