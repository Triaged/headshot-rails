class AddMissingIndexes < ActiveRecord::Migration
  def change
  	add_index :devices, :user_id
    add_index :imported_users, :company_id
    add_index :departments, :company_id
  end
end
