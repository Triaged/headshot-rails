class DownloadsController < ApplicationController
	layout "download"
	
	def show
		@platform = :android if browser.android?
		@platform = :ios if browser.ios?


		respond_to do |format|
      format.html          # /app/views/home/index.html.erb
      format.html.mobile    # /app/views/home/index.html+phone.erb
    end
	end

	def txt
		phone_number = params[:sms_capture][:phone_number]
		sms_app_link =SmsService.new()
    @result = sms_app_link.deliver!
    @response =  @result ? "Great, we texted you at #{phone_number}." : "Sorry, your phone number looks invalid."
	end

	def txt_stored
		phone_number = current_user.employee_info.cell_phone
		sms_app_link = SmsService.new(phone_number)
		@result = sms_app_link.deliver!
    @response =  @result ? "Great, we texted you at #{phone_number}." : "Sorry, your phone number looks invalid."
	end

end
