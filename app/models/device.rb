class Device < ActiveRecord::Base

	belongs_to :user, counter_cache: true
	
	validates :application_id, presence: true
	#validates :token, uniqueness: true

	before_save :strip_spaces

  def strip_spaces
  	token.delete(' ') if token
  end
end
