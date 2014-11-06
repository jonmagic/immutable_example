class ChargeState < ActiveRecord::Base
  belongs_to :charge

  enum :states => {
    :processing => 0,
    :processed  => 1,
    :failed     => 2
  }
end
