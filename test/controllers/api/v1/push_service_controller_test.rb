require 'test_helper'

class API::V1::PushServiceControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

end
