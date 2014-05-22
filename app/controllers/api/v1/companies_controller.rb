class API::V1::CompaniesController < APIController

	def show
		respond_with current_company
	end

end
