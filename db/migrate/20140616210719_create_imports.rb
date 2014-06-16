class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.references :company

      t.timestamps
    end
  end
end
