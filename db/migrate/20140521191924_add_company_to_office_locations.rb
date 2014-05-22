class AddCompanyToOfficeLocations < ActiveRecord::Migration
  def change
    add_reference :office_locations, :company, index: true
  end
end
