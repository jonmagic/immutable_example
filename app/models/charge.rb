class Charge < ActiveRecord::Base
  belongs_to :account

  scope :all_for_account, ->(account) { where(:account => account) }

  def self.find_for_account(account, charge_id)
    all_for_account(account).find(charge_id)
  end
end
