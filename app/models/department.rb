class Department < ActiveRecord::Base
	belongs_to :company
	has_many :users, counter_cache: true

	validates :name, uniqueness: {scope: :company}

	after_create :push_entity

	DEFAULT_DEPARTMENTS = ['Engineering', 'Services', 'Operations', 'Marketing', 'Human Resources', 'Finance', 'Product', 'Project Management', 
		'Purchasing', 'Sales', 'IT', 'Design', 'Quality Assurance', 'Operations', 'Marketing', 'Client Services', 'Customer Support']

	def self.create_default_departments company
		DEFAULT_DEPARTMENTS.each {|dept| Department.create(name: dept, company: company)}
	end

	def push_entity
		EntityPush.perform_async(self.company.id, "department", self.id)
	end

	def user_included user
		self.users.include? user
	end


end






