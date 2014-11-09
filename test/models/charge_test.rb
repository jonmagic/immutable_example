require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:julia)
    @charge  = charges(:charge_for_julia)
  end

  test ".all_for_account returns charges for account only" do
    assert_equal [@charge], Charge.all_for_account(@account)
  end

  test ".find_for_account returns specific charge for account" do
    assert_equal @charge, Charge.find_for_account(@account, @charge.id)
  end

  test ".find_for_account raises error trying to find charge for wrong account" do
    assert_raises(ActiveRecord::RecordNotFound) do
      Charge.find_for_account(accounts(:jon), @charge.id)
    end
  end

  test "record is read only after being created" do
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      @charge.update(:amount_in_cents => 500)
    end
  end

  test "#states returns history of states for charge in chronological order" do
    assert_equal \
      [charge_states(:state_processing_for_julia), charge_states(:state_processed_for_julia)],
      @charge.states
  end

  test "#state returns the current (aka last) state" do
    assert_equal charge_states(:state_processed_for_julia), @charge.state
  end

  test ".all_in_progress only returns charge that is still in progress" do
    assert_equal [charges(:charge_for_arthur)], Charge.all_in_progress
  end

  test ".all_finalized only returns charges that have been finalized" do
    assert_equal \
      [charges(:charge_for_julia), charges(:charge_for_jon)],
      Charge.all_finalized
  end

  test ".all_with_state only returns charges for specific state" do
    assert_equal [charges(:charge_for_arthur)], Charge.all_with_state(:processing)
    assert_equal [charges(:charge_for_julia)], Charge.all_with_state(:processed)
    assert_equal [charges(:charge_for_jon)], Charge.all_with_state(:failed)
  end
end
