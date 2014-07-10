class CreateHomeLocations < ActiveRecord::Migration
  def change
    create_table :home_locations do |t|
      t.references :user
      t.string :street_address
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
