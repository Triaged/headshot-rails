class Admin::CompaniesController < AdminController

	def index
    @companies = Company.all
  end

  # GET /admin/providers/1
  def show
  	@company = Company.find(params[:id])
  end

  def new
  	@company = Company.new
  end

  def create
  	@company = Company.new(company_params)

    if @company.save
      redirect_to admin_company_path(@company), success: 'Company was successfully created.'
    else
      render action: 'new'
    end
  end

end
