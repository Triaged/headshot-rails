class DestroyInstalledAppField < ActiveRecord::Migration
  def change
  	remove_column :users, :installed_app
  end
end
