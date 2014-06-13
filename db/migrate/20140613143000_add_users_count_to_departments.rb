class AddUsersCountToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :users_count, :integer
  end
end
