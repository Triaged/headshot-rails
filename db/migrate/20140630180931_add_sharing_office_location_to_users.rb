class AddSharingOfficeLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sharing_office_location, :boolean, default: false
  end
end
