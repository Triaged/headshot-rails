class EmployeeInfoSerializer < ApplicationSerializer
  attributes :id, :job_title, :job_start_date, :birth_date, :cell_phone, :office_phone

  
  def job_start_date
  	object.job_start_date.to_time if object.job_start_date
  end

  def birth_date
  	object.birth_date.to_time if object.birth_date
  end
 
end
