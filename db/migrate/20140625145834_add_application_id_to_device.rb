class AddApplicationIdToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :application_id, :string
  end
end
