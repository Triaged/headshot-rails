class AddLocationsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :primary_office_location, index: true
    add_reference :users, :current_office_location, index: true
  end
end
