class DownloadsController < ApplicationController
	layout "download"
	
	def show
		respond_to do |format|
      format.html          # /app/views/home/index.html.erb
      format.html.mobile    # /app/views/home/index.html+phone.erb
    end
	end

	def txt
		sms_app_link =SmsService.new(params[:sms_capture][:phone_number])
    @result = sms_app_link.deliver!
    @response =  @result ? "Great, we texted you a link to the app!" : "Sorry, your phone number looks invalid."
	end

end
