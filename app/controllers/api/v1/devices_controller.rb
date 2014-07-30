class API::V1::DevicesController < APIController

	def create
		@device = current_user.devices.where(application_id: device_params[:application_id], service: device_params[:service]).first ||
									current_user.devices.where(token: device_params[:token], service: device_params[:service]).first

		puts @device.inspect
		unless @device
			@device = current_user.devices.find_or_initialize_by(token: device_params[:token], service: device_params[:service])
		end

		@device.update(device_params.merge(logged_in: true))
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
