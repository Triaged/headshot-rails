class API::V1::OfficeLocationsController < APIController
  before_action :set_office_location, only: [:show, :edit, :update, :destroy, :entered, :exited]

  # GET /api/v1/office_locations
  def index
    @office_locations = current_company.office_locations.all
    respond_with @office_locations
  end

  # GET /api/v1/office_locations/1
  def show
    respond_with @office_location
  end

  def entered
    OfficeLocationService.new(current_user, @office_location).enter!
    render :json => { "message" => "ok" }, :status => 200
  end

  def exited
    OfficeLocationService.new(current_user, @office_location).exit!
    render :json => { "message" => "ok" }, :status => 200
  end

  # POST /api/v1/office_locations
  def create
    @office_location = current_company.office_locations.create(office_location_params)
    respond_with @office_location, location: api_v1_office_location_path(@office_location)
  end

  # PATCH/PUT /api/v1/office_locations/1
  def update
    @office_location.update(office_location_params)
    respond_with @office_location, location: api_v1_office_location_path(@office_location)
  end

  # DELETE /api/v1/office_locations/1
  def destroy
    @office_location.destroy
    respond_with @office_location
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office_location
      @office_location = current_company.office_locations.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def office_location_params
      params[:office_location].permit(:street_address, :city, :zip_code, :state, :country)
    end
end
