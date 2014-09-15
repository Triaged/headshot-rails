class API::V1::CompaniesController < APIController

	def show
		timestamp = Time.at(params[:timestamp].to_f/1000).to_s
		expires_now
		respond_with current_company, updated_at: timestamp
	end

end
