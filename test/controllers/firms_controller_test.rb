require 'test_helper'

class FirmsControllerTest < ActionController::TestCase
  test "should get json1" do
    get :json1
    assert_response :success
  end

  test "should get json2" do
    get :json2
    assert_response :success
  end

  test "should get scan" do
    get :scan
    assert_response :success
  end

end
