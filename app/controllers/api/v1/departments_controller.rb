class API::V1::DepartmentsController < APIController
	before_action :set_department, only: [:show, :edit, :update, :destroy]

	def index
		@departments = current_company.departments.all
		respond_with @departments
	end

	def show
		respond_with @department
	end

	# POST /api/v1/departments
  def create
    @department = current_company.departments.find_or_create(department_params)
    respond_with @department, location: api_v1_department_path(@department)
  end

  # PATCH/PUT /api/v1/office_locations/1
  def update
    @department.update(department_params)
    respond_with @department, location: api_v1_department_path(@department)
  end

  # DELETE /api/v1/office_locations/1
  def destroy
    @department.destroy
    respond_with @department
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = current_company.departments.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def department_params
    params[:department].permit(:name)
  end

end
