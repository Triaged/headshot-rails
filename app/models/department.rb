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
		users = self.company.users
		devices = users.collect {|user| user.devices.where(service: 'android').all }.flatten
		Rails.logger.info devices
		devices = devices.to_a.uniq{ |device| device.token }

		client = AWS::SNS::Client.new

		devices.each do |device|
			gcm_payload = {data: {type: "department", id: self.id.to_s}}.to_json
			message = { "default" => "new entity", "GCM" => gcm_payload }.to_json
			client.publish( message: message, target_arn: device.arn, message_structure: 'json' )
		end
	end

end






