class API::V1::DevicesController < ApplicationController

	def create
		@device = current_user.devices.find_or_initialize_by(token: device_params[:token], service: device_params[:service])
		@device.update(device_params)
		respond_with @device, location: api_v1_device_path(@device)
	end

private 
	
	def device_params
		params[:device].permit(:token, :os_version, :service)
	end
end
