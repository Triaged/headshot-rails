class AddOfficeInfoToEmployeeInfos < ActiveRecord::Migration
  def change
    add_reference :employee_infos, :home_office_location, index: true
    add_reference :employee_infos, :current_office_location, index: true
  end
end
