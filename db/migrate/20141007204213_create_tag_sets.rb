class CreateTagSets < ActiveRecord::Migration
  def change
    create_table :tag_sets do |t|
      t.string :name

      t.timestamps
    end
  end
end
