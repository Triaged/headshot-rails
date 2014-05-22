class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_reference :users, :company, index: true
    add_reference :users, :team, index: true
  end
end
