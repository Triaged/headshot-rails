class AddFieldsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :uses_departments, :boolean, default: true
  end
end
