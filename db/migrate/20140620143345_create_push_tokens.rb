class CreatePushTokens < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user
      t.string :service
      t.string :token
      t.integer :count
      t.string :os_version
      t.datetime :last_notified_at
      t.timestamps
    end
  end
end
