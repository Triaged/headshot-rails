class CompanySerializer < ApplicationSerializer
  attributes :id, :name

  has_many :office_locations
end
