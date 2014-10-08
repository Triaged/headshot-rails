class CreateUserTagSetItems < ActiveRecord::Migration
  def change
    create_table :user_tag_set_items do |t|
      t.references :user, index: true
      t.references :tag_set_item, index: true

      t.timestamps
    end
  end
end
