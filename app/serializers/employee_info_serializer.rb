class EmployeeInfoSerializer < ApplicationSerializer
  attributes :id, :job_title, :job_start_date, :birth_date, :cell_phone, :office_phone

  has_one :home_office_location
  has_one :current_office_location

 
end
