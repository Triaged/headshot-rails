class API::V1::CompaniesController < APIController

	def show
		respond_with Company.find(current_company.id).includes(:users, :departments, :office_locations)
	end

end
