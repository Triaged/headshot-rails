class Admin::OfficeLocationsController < ApplicationController
	before_action :set_company
	before_action :set_office_location, only: [:show, :edit, :update, :destroy]

  # GET /manage/office_locations
  def index
    @office_locations = @company.office_locations.all
  end

  # GET /manage/office_locations/1
  def show
  end

  # GET /manage/office_locations/new
  def new
    @office_location = @company.office_locations.build
  end

  # GET /manage/office_locations/1/edit
  def edit
  end

  # POST /manage/office_locations
  def create
    @office_location = @company.office_locations.new(office_location_params)

    if @office_location.save
      redirect_to admin_company_path(@company), success: 'Office location was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /manage/office_locations/1
  def update
    if @office_location.update(office_location_params)
      redirect_to admin_company_path(@company), success: 'Office location was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /manage/office_locations/1
  def destroy
    @office_location.destroy
    redirect_to admin_company_path(@company), success: 'Office location was successfully destroyed.'
  end

  private
  def set_company
  	@company = Company.find(params[:company_id])
  end
  	
  
    # Use callbacks to share common setup or constraints between actions.
    def set_office_location
      @office_location = @company.office_locations.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def office_location_params
      params[:office_location].permit(:name, :street_address, :city, :state, :zip_code, :country)
    end
end
