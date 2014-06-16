class AddFullNameToImportedUsers < ActiveRecord::Migration
  def change
    add_column :imported_users, :full_name, :string
  end
end
