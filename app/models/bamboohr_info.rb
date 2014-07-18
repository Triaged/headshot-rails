class BamboohrInfo < ActiveRecord::Base
  belongs_to :company

  def info_set?
  	self.api_key || self.subdomain
  end
  
end
