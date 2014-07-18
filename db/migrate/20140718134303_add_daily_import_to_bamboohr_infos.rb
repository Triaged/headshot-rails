class AddDailyImportToBamboohrInfos < ActiveRecord::Migration
  def change
    add_column :bamboohr_infos, :daily_import, :boolean
  end
end
