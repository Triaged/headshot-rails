class CompanySerializer < ApplicationSerializer
  attributes :id, :name, :uses_departments

  has_many :users
  has_many :office_locations
  has_many :departments

  def users
  	@options[:updated_at] ? object.users.where("updated_at >= ?", DateTime.parse(@options[:updated_at])) : object.users
  end

  def office_locations
  	@options[:updated_at] ? object.office_locations.where("updated_at >= ?", DateTime.parse(@options[:updated_at])) : object.users
  end

  def departments
  	@options[:updated_at] ? object.departments.where("updated_at >= ?", DateTime.parse(@options[:updated_at])) : object.users
  end
end
