class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :office_locations
end
