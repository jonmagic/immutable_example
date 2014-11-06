class ChargeState < ActiveRecord::Base
  belongs_to :charge

  default_scope { order("created_at ASC") }

  enum :states => {
    :processing => 0,
    :processed  => 1,
    :failed     => 2
  }
end
