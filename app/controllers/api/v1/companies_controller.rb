class API::V1::CompaniesController < APIController

	def show
		respond_with Company.where(id: current_company.id).includes(:users, :departments, :office_locations)
	end

end
