class API::V1::DevicesController < APIController

	def create
		# First look for a device with the application_id
		@device = current_user.devices.where(application_id: device_params[:application_id], service: device_params[:service]).first ||
									current_user.devices.where(token: device_params[:token], service: device_params[:service]).first

		unless @device
			# then look for a device with the device token, or a create a new one
			@device = current_user.devices.find_or_initialize_by(token: device_params[:token], service: device_params[:service])
		end

		@device.update(device_params)
		respond_with @device, location: api_v1_devices_path(@device)
	end

	def sign_out
		@device = Device.find(params[:id])
		@device.update(logged_in: false)
		
		respond_with @device, location: api_v1_devices_path(@device)
	end

private 
	
	def device_params
		params[:device].permit(:token, :os_version, :service, :application_id)
	end
end
