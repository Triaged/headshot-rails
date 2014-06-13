class CompanySerializer < ApplicationSerializer
  attributes :id, :name, :uses_departments

  has_many :office_locations
end
