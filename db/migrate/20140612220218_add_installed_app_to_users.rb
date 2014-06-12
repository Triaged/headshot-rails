class AddInstalledAppToUsers < ActiveRecord::Migration
  def change
    add_column :users, :installed_app, :boolean
  end
end
