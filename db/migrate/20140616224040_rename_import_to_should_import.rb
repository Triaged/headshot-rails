class RenameImportToShouldImport < ActiveRecord::Migration
  def change
  	rename_column :imported_users, :import, :should_import
  end
end
