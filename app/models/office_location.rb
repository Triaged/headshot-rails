class OfficeLocation < ActiveRecord::Base

	geocoded_by :full_address   # can also be an IP address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	obj.state = geo.state
	    obj.zip_code = geo.postal_code
	    obj.country = geo.country_code
		end
	end
	belongs_to :company

	after_validation :geocode, :reverse_geocode
	after_create :push_entity


	def full_address
		"#{street_address} #{city}, #{state} #{zip_code} #{country}"
	end

	def display_name
		self.name.nil? || self.name.empty? ? self.street_address : self.name
	end

	def push_entity
		EntityPush.perform_async(self.company.id, "office_location", self.id)
	end

end
