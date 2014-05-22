class EmployeeInfo < ActiveRecord::Base

	belongs_to :user
	belongs_to :home_office_location, class_name: "OfficeLocation"
	belongs_to :current_office_location, class_name: 'OfficeLocation'
end
