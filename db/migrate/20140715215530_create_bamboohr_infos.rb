class CreateBamboohrInfos < ActiveRecord::Migration
  def change
    create_table :bamboohr_infos do |t|
      t.string :subdomain
      t.string :api_key
      t.references :company, index: true

      t.timestamps
    end
  end
end
