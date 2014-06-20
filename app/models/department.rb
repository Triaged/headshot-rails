class Department < ActiveRecord::Base
	belongs_to :company
	has_many :users

	validates :name, uniqueness: {scope: :company}

	DEFAULT_DEPARTMENTS = ['Engineering', 'Services', 'Operations', 'Marketing', 'Human Resources', 'Finance', 'Product', 'Project Management', 
		'Purchasing', 'Sales', 'IT', 'Design', 'Quality Assurance', 'Operations', 'Marketing', 'Client Services', 'Customer Support']

	def self.create_default_departments company
		DEFAULT_DEPARTMENTS.each {|dept| Department.create(name: dept, company: company)}
	end

end






