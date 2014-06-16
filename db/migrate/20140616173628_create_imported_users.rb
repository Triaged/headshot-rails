class CreateImportedUsers < ActiveRecord::Migration
  def change
    create_table :imported_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :import
      t.references :company

      t.timestamps
    end
  end
end
