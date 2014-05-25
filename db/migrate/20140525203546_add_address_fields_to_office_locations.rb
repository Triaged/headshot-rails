class AddAddressFieldsToOfficeLocations < ActiveRecord::Migration
  def change
  	rename_column :office_locations, :address, :street_address
  	add_column :office_locations, :zip_code, :string
  	add_column :office_locations, :city, :string
  	add_column :office_locations, :state, :string
  	add_column :office_locations, :country, :string
  end
end
