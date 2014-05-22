class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :title
      t.string :short_title
      t.boolean :active
      t.boolean :oauth
      t.string :oauth_path
      t.string :large_icon
      t.string :small_icon

      t.timestamps
    end
  end
end
