class OfficeLocation < ActiveRecord::Base

geocoded_by :address   # can also be an IP address
reverse_geocoded_by :latitude, :longitude
after_validation :reverse_geocode  # auto-fetch address

belongs_to :company

end
