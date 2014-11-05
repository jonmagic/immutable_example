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
end
