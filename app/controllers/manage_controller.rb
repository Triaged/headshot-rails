class ManageController < ApplicationController
	before_action :validates_manager


	def validates_manager
		redirect_to download_path unless current_user.admin?
	end

end
