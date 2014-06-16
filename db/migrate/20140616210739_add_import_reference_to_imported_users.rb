class AddImportReferenceToImportedUsers < ActiveRecord::Migration
  def change
    add_reference :imported_users, :import, index: true
  end
end
