class ManageController < ApplicationController
	before_action :validates_manager


	def validates_manager
		redirect_to root_url unless current_user.admin?
	end

end
