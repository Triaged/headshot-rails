class AddAvatarDataToImportedUsers < ActiveRecord::Migration
  def change
    add_column :imported_users, :avatar, :text
  end
end
