class Admin::CompaniesController < AdminController

	def index
    @companies = Company.all
  end

  # GET /admin/providers/1
  def show
  	@company = Company.find(params[:id])
  end

end
