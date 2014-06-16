class Provider < ActiveRecord::Base
	extend FriendlyId
	
	friendly_id :name, use: [:slugged, :finders]

	def self.named name
  	Provider.where(name: name).first
  end
end
