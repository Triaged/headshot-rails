class EmployeeInfo < ActiveRecord::Base

	belongs_to :user

	phony_normalize :cell_phone, :default_country_code => 'US'
	phony_normalize :office_phone, :default_country_code => 'US'

	acts_as_birthday :birth_date, :job_start_date

	
end
