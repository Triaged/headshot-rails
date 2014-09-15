class API::V1::CompaniesController < APIController

	def show
		expires_now
		timestamp = Time.at(params[:timestamp].to_f/1000).to_s
		respond_with current_company, updated_at: timestamp
	end

end
