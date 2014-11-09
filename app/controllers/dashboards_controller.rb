class DashboardsController < ApplicationController
  def charges
    @processing = Charge.all_with_state(:processing).count
    @processed  = Charge.all_with_state(:processed).count
    @failed     = Charge.all_with_state(:failed).count
  end
end
