class AddLinksToEmployeeInfos < ActiveRecord::Migration
  def change
    add_column :employee_infos, :website, :string
    add_column :employee_infos, :linkedin, :string
  end
end
