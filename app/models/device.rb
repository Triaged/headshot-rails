class Device < ActiveRecord::Base

	belongs_to :user
	before_create :strip_spaces

	validates :token, uniqueness: true

  def strip_spaces
  	token.delete(' ')
  end
end
