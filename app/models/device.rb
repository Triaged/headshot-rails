class Device < ActiveRecord::Base

	belongs_to :user
	
	validates :application_id, presence: true
	validates :token, uniqueness: true

	before_create :strip_spaces

  def strip_spaces
  	token.delete(' ')
  end
end
