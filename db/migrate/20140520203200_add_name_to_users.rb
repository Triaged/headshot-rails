class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end
end
