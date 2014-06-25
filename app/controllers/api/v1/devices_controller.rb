class API::V1::DevicesController < APIController

	def create
		if device_params[:token]
			@device = current_user.devices.find_or_initialize_by(token: device_params[:token], service: device_params[:service])
		else
			@device = current_user.devices.find_or_initialize_by(application_id: device_params[:application_id], service: device_params[:service])
		end	
		
		@device.update(device_params)
		render :json => { "message" => "ok" }, :status => 200
	end

private 
	
	def device_params
		params[:device].permit(:token, :os_version, :service, :application_id)
	end
end