class API::V1::CompaniesController < APIController

	def show
		timestamp = Time.at(params[:timestamp].to_f/1000).to_s
		exclude_current_user = false #params[:exclude_current_user]
		expires_now
		respond_with Company.where(id: current_company.id).includes(:users, :departments, :office_locations), updated_at: timestamp, exclude_current_user: exclude_current_user
	end

end
