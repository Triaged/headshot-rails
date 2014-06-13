class AddUsersCountToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :users_count, :integer, default: 0
  end
end
