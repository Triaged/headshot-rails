class Company < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name, use: [:slugged, :finders]

	has_many :users
	has_many :office_locations

end
