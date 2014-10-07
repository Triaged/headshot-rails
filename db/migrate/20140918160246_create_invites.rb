class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email, :phone
      t.timestamps
    end
  end
end
