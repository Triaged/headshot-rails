class HomeLocation < ActiveRecord::Base

	geocoded_by :full_address   # can also be an IP address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	obj.state = geo.state
	    obj.zip_code = geo.postal_code
	    obj.country = geo.country_code
		end
	end
	after_validation :geocode, :reverse_geocode

	belongs_to :user

	def full_address
		"#{street_address} #{city}, #{state} #{zip_code} #{country}"
	end

end
