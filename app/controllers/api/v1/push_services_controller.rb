class API::V1::PushServicesController < APIController
  

  def create
  	Sinch::PushService.new(push_service_params).deliver!
  	render :json => 'ok' 
  end

private
	# Only allow a trusted parameter "white list" through.
    def push_service_params
      params[:push_service].permit(:push_token, :payload, :message_body)
    end
end
