class AddLoggedInToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :logged_in, :boolean, default: true
  end
end
