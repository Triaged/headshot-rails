class CompanySerializer < ApplicationSerializer
  attributes :id, :name, :uses_departments

  has_many :users
  has_many :office_locations
  has_many :departments
end
