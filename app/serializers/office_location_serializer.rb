class OfficeLocationSerializer < ApplicationSerializer
  attributes :id, :name, :street_address, :city, :state, :zip_code, :country, :longitude, :latitude
end
