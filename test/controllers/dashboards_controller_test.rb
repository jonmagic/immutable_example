require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  test "should get charges" do
    get :charges
    assert_response :success
    assert_not_nil assigns(:processing)
    assert_not_nil assigns(:processed)
    assert_not_nil assigns(:failed)
  end
end
