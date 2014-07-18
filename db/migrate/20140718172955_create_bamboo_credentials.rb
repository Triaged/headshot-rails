class CreateBambooCredentials < ActiveRecord::Migration
  def change
    create_table :bamboo_credentials do |t|
      t.integer :company_id
      t.string :subdomain
      t.string :api_key
    end
  end
end
