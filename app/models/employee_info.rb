class EmployeeInfo < ActiveRecord::Base


	belongs_to :user
	belongs_to :imported_user

	phony_normalize :cell_phone, :default_country_code => 'US'
	phony_normalize :office_phone, :default_country_code => 'US'

	acts_as_birthday :birth_date, :job_start_date

	validates :website, :url => {:allow_nil => true}
	validates :linkedin, :url => {:allow_nil => true}

	before_validation :add_scheme

	def add_scheme
  	self.website = "http://#{self.website}" unless self.website=~/^https?:\/\//
  	self.linkedin = "http://#{self.linkedin}" unless self.linkedin=~/^https?:\/\//
  end

	
end
