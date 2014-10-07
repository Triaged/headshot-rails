class CreateTagSetItems < ActiveRecord::Migration
  def change
    create_table :tag_set_items do |t|
      t.string :name
      t.references :tag_set

      t.timestamps
    end
  end
end
