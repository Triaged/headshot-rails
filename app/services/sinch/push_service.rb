class Sinch::PushService

	def init (params)
		@push_token = params[:push_token]
		@payload = params[:payload]
	end

	def deliver!
		Rails.logger.info @push_token
		Rails.logger.info @payload
	end

end