class AddFieldsToImportedUsers < ActiveRecord::Migration
  def change
    add_column :imported_users, :department, :string
    add_column :imported_users, :location, :string
    add_column :imported_users, :avatar_url, :string
  end
end
