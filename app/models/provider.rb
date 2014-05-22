class Provider < ActiveRecord::Base

	def self.named name
  	Provider.where(name: name).first
  end
end
