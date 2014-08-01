class CreatePilots < ActiveRecord::Migration
  def change
    create_table :pilots do |t|
      t.string :email
      t.string :company

      t.timestamps
    end
  end
end
