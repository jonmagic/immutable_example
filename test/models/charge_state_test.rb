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
end
