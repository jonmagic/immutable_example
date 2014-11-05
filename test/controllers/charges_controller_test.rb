require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:arthur)
    @charge = charges(:charge_for_arthur)
  end

  test "should get index" do
    get :index, account_id: @account.id
    assert_response :success
    assert_not_nil assigns(:charges)
  end

  test "should get new" do
    get :new, account_id: @account.id
    assert_response :success
  end

  test "should create charge" do
    assert_difference('Charge.count') do
      post :create, account_id: @account.id, charge: { account_id: @charge.account_id, amount_in_cents: @charge.amount_in_cents, created_at: @charge.created_at }
    end

    assert_redirected_to account_charge_path(assigns(:account), assigns(:charge))
  end

  test "should show charge" do
    get :show, account_id: @account.id, id: @charge
    assert_response :success
  end
end
