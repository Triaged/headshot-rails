class AddCurrentAvailabilityToEmployeeInfos < ActiveRecord::Migration
  def change
    add_column :employee_infos, :current_availability, :integer
  end
end
