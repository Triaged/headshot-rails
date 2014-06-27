class API::V1::CompaniesController < APIController

	def show
		respond_with current_company.includes(:users, :departments, :office_locations)
	end

end
