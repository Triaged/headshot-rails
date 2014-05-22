require 'test_helper'

class API::V1::OfficeLocationsControllerTest < ActionController::TestCase
  setup do
    @api_v1_office_location = api_v1_office_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_office_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_office_location" do
    assert_difference('API::V1::OfficeLocation.count') do
      post :create, api_v1_office_location: {  }
    end

    assert_redirected_to api_v1_office_location_path(assigns(:api_v1_office_location))
  end

  test "should show api_v1_office_location" do
    get :show, id: @api_v1_office_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_office_location
    assert_response :success
  end

  test "should update api_v1_office_location" do
    patch :update, id: @api_v1_office_location, api_v1_office_location: {  }
    assert_redirected_to api_v1_office_location_path(assigns(:api_v1_office_location))
  end

  test "should destroy api_v1_office_location" do
    assert_difference('API::V1::OfficeLocation.count', -1) do
      delete :destroy, id: @api_v1_office_location
    end

    assert_redirected_to api_v1_office_locations_path
  end
end
