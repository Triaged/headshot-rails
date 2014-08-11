class Admin::DepartmentsController < AdminController
	before_action :set_company
	before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /manage/departments
  def index
    @departments = @company.departments.all
  end

  # GET /manage/departments/1
  def show
  end

  # GET /manage/departments/new
  def new
    @department = @company.departments.build
  end

  # GET /manage/departments/1/edit
  def edit
  end

  # POST /manage/departments
  def create
    @department = @company.departments.new(department_params)

    if @department.save
      redirect_to admin_company_path(@company), success: 'Department was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /manage/departments/1
  def update
    if @department.update(department_params)
      redirect_to admin_company_path(@company), success: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /manage/departments/1
  def destroy
    @department.destroy
    redirect_to admin_company_path(@company), success: 'Department was successfully destroyed.'
  end

  private
  	def set_company
  		@company = Company.find(params[:company_id])
  	end

    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = @company.departments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def department_params
      params[:department].permit(:name)
    end
end
