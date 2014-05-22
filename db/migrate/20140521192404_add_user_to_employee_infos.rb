class AddUserToEmployeeInfos < ActiveRecord::Migration
  def change
    add_reference :employee_infos, :user, index: true
  end
end
