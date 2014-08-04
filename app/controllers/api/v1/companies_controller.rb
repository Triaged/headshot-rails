class API::V1::CompaniesController < APIController

	def show
		timestamp = Time.at(params[:timestamp].to_f).to_s
		respond_with Company.where(id: current_company.id).includes(:users, :departments, :office_locations), updated_at: timestamp
	end

end
