class EmployeeInfoSerializer < ActiveModel::Serializer
  attributes :id, :job_title, :job_start_date, :birth_date, :cell_phone, :office_phone, :home_office_location, :current_office_location

 
end
