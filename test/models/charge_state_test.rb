require 'test_helper'

class ChargeStateTest < ActiveSupport::TestCase
  test "default scope orders by created_at ASC" do
    states = ChargeState.all

    states.each_with_index do |state, n|
      if states[n + 1]
        assert state.created_at < states[n + 1].created_at
      end
    end
  end

  test "#in_progress? returns true when processing" do
    assert charge_states(:state_processing_for_arthur).in_progress?
  end

  test "#in_progress? returns false when processed" do
    refute charge_states(:state_processed_for_julia).in_progress?
  end

  test "#in_progress? returns false when failed" do
    refute charge_states(:state_failed_for_jon).in_progress?
  end
end
