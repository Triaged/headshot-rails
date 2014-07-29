class AddAvatarDataToImportedUsers < ActiveRecord::Migration
  def change
    add_column :imported_users, :avatar_data, :text
  end
end
