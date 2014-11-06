class Charge < ActiveRecord::Base
  belongs_to :account
  has_many :states, :class_name => "ChargeState"

  scope :all_for_account, ->(account) { where(:account => account) }

  def self.find_for_account(account, charge_id)
    all_for_account(account).find(charge_id)
  end

  def readonly?
    persisted?
  end

  def state
    states.last
  end
end
