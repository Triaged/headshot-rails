class DownloadsController < ApplicationController
	layout "download"
	
	def show
		respond_to do |format|
      format.json
      format.html          # /app/views/home/index.html.erb
      format.html.mobile    # /app/views/home/index.html+phone.erb
    end
	end
end
