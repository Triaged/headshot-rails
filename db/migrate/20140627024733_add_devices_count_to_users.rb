class AddDevicesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :devices_count, :integer
  end
end
