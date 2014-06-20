class PushToken < ActiveRecord::Base

	belongs_to :user
	before_create :strip_spaces

  def strip_spaces
  	token.delete(' ')
  end
end
