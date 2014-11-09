class ChargeState < ActiveRecord::Base
  belongs_to :charge

  default_scope { order("created_at ASC") }

  enum :state => {
    :processing => 0,
    :processed  => 1,
    :failed     => 2
  }

  def readonly?
    persisted?
  end

  def self.final_states
    [
      states[:processed],
      states[:failed]
    ]
  end

  def in_progress?
    !finalized?
  end

  def finalized?
    self.class.final_states.include?(read_attribute(:state))
  end
end
