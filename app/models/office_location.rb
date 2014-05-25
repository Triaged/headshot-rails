class OfficeLocation < ActiveRecord::Base

geocoded_by :address   # can also be an IP address
reverse_geocoded_by :latitude, :longitude do |obj,results|
  if geo = results.first
  	obj.street_address = geo.street_address
    obj.city    = geo.city
    obj.state = geo.state
    obj.zip_code = geo.postal_code
    obj.country = geo.country_code
	end
end
after_validation :reverse_geocode  # auto-fetch address

belongs_to :company

end
