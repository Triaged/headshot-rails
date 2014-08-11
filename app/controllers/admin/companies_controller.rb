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

  def edit
    @company = Company.find(params[:id])
  end

  def create
  	@company = Company.new(company_params)

    if @company.save
      redirect_to admin_company_path(@company), success: 'Company was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @company.update(company_params)
      redirect_to admin_company_path, success: 'Company was successfully updated.'
    else
      render :edit
    end
  end

private

	def company_params
		params[:company].permit(:name, :uses_departments)
	end

end
