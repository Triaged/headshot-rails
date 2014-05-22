class OfficeLocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :longitude, :latitude
end
