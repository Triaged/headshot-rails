class CompanySerializer < ApplicationSerializer
  attributes :id, :name, :uses_departments, :logo_url

  has_many :users
  has_many :office_locations
  has_many :departments
  has_many :tag_sets

  def logo_url
    object.logo.url
  end

  def users
  	@options[:updated_at] ? object.users.with_deleted.where("updated_at >= ?", DateTime.parse(@options[:updated_at])) : object.users.with_deleted
  end

  def office_locations
  	@options[:updated_at] ? object.office_locations.where("updated_at >= ?", DateTime.parse(@options[:updated_at])) : object.office_locations
  end

  def departments
  	@options[:updated_at] ? object.departments.where("updated_at >= ?", DateTime.parse(@options[:updated_at])) : object.departments
  end

  def tag_sets
    TagSet.all
  end

end
