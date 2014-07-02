class FixUsersSlugIndex < ActiveRecord::Migration
  def change
  	remove_index :users, :slug
  	add_index :users, :slug
	end
end
