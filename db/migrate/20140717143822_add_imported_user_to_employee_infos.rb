class AddImportedUserToEmployeeInfos < ActiveRecord::Migration
  def change
    add_reference :employee_infos, :imported_user, index: true
  end
end
