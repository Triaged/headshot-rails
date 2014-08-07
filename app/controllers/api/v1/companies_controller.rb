class API::V1::CompaniesController < APIController

	def show
		timestamp = Time.at(params[:timestamp].to_f/1000).to_s
		respond_with Company.where(id: current_company.id).includes(:users, :departments, :office_locations).merge(User.with_deleted), updated_at: timestamp
	end

end
