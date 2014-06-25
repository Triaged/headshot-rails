class API::V1::DevicesController < APIController

	def create
		if device_params[:token]
			@device = current_user.devices.find_or_initialize_by(token: device_params[:token], service: device_params[:service])
		else
			@device = current_user.devices.find_or_initialize_by(application_id: device_params[:application_id], service: device_params[:service])
		end	
		
		@device.update(device_params)
		respond_with @device, location: api_v1_device_path(@device)
	end

private 
	
	def device_params
		params[:device].permit(:token, :os_version, :service, :application_id)
	end
end