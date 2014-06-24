class DownloadsController < ApplicationController
	has_mobile_fu
	layout "download"
	
	def show
		respond_to do |format|
      format.json
      format.html          # /app/views/home/index.html.erb
      format.html.mobile    # /app/views/home/index.html+phone.erb
    end
	end
end
