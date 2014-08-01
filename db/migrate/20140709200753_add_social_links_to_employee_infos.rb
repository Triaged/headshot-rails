class AddSocialLinksToEmployeeInfos < ActiveRecord::Migration
  def change
    add_column :employee_infos, :twitter_url, :string
    add_column :employee_infos, :linkedin_url, :string
    add_column :employee_infos, :website_url, :string
  end
end
