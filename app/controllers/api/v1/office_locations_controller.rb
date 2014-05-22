class API::V1::OfficeLocationsController < APIController
  before_action :set_office_location, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/office_locations
  def index
    @office_locations = current_company.office_locations.all
  end

  # GET /api/v1/office_locations/1
  def show
  end

  
  # POST /api/v1/office_locations
  def create
    @office_location = current_company.office_locations.build(office_location_params)

    if @api_v1_office_location.save
      redirect_to api_v1_office_locations_url(@office_location), notice: 'Office location was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /api/v1/office_locations/1
  def update
    if @office_location.update(office_location_params)
      redirect_to api_v1_office_locations_url(@office_location), notice: 'Office location was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /api/v1/office_locations/1
  def destroy
    @office_location.destroy
    redirect_to api_v1_office_locations_url, notice: 'Office location was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office_location
      @office_location = current_company.office_locations.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def office_location_params
      params[:office_location]
    end
end
