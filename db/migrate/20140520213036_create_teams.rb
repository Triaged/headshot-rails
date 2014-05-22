class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :company, index: true

      t.timestamps
    end
  end
end
