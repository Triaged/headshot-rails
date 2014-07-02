class ManageController < ApplicationController
	before_action :validates_manager
	force_ssl if: :ssl_configured?

  def ssl_configured?
    Rails.env.production?
  end


	def validates_manager
		redirect_to download_path unless current_user.admin?
	end

end
