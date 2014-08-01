class AddArnToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :arn, :string
  end
end
