class AddChallengeCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :challenge_code, :string
  end
end
