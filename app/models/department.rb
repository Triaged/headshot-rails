class Department < ActiveRecord::Base
	belongs_to :company
	has_many :users


	def self.create_default_departments company
		Department.create(name: 'Engineering', company: company)
		Department.create(name: 'Services', company: company)
		Department.create(name: 'Operations', company: company)
		Department.create(name: 'Marketing', company: company)
		Department.create(name: 'Human Resources', company: company)
		Department.create(name: 'Finance', company: company)
		Department.create(name: 'Purchasing', company: company)
		Department.create(name: 'Sales', company: company)
		Department.create(name: 'IT', company: company)
		Department.create(name: 'Design', company: company)
		Department.create(name: 'Quality Assurance', company: company)
		Department.create(name: 'Operations', company: company)
		Department.create(name: 'Marketing', company: company)
		Department.create(name: 'Client Services', company: company)
		Department.create(name: 'Customer Support', company: company)
	end

end






