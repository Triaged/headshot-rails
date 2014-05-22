class CreateEmployeeInfos < ActiveRecord::Migration
  def change
    create_table :employee_infos do |t|
      t.string :job_title
      t.string :cell_phone
      t.string :office_phone
      t.date :job_start_date
      t.date :birth_date

      t.timestamps
    end
  end
end
