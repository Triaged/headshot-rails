class AddPriorityToTagSets < ActiveRecord::Migration
  def change
    add_column :tag_sets, :priority, :integer
  end
end
