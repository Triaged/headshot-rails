class CreateProviderCredentials < ActiveRecord::Migration
  def change
    create_table :provider_credentials do |t|
      t.references :user, index: true
      t.references :provider, index: true
      t.references :company, index: true
      t.string :uid
      t.string :access_token
      t.string :token_secret
      t.string :refresh_token

      t.timestamps
    end
  end
end
