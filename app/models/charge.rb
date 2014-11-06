class Charge < ActiveRecord::Base
  belongs_to :account
  has_many :states, :class_name => "ChargeState"
  has_many :charge_states

  default_scope { order("created_at asc") }

  scope :all_for_account, ->(account) { where(:account => account) }

  scope :find_for_account, ->(account, charge_id) {
    all_for_account(account).find(charge_id)
  }

  scope :all_in_progress, -> {
    where("id in (select cs1.charge_id from charge_states as cs1 left join charge_states as cs2 on (cs1.charge_id = cs2.charge_id and cs1.created_at < cs2.created_at) where cs2.id is null and cs1.state = 0)")
  }

  scope :all_finalized, -> {
    where("id in (select cs1.charge_id from charge_states as cs1 left join charge_states as cs2 on (cs1.charge_id = cs2.charge_id and cs1.created_at < cs2.created_at) where cs2.id is null and cs1.state in (1,2))")
  }

  before_create :processing!

  def readonly?
    persisted?
  end

  def state
    states.last
  end

  def processing!
    states.build(:state => ChargeState.states[:processing])
  end

  def processed!
    states.create(:state => ChargeState.states[:processed])
  end

  def failed!
    states.create(:state => ChargeState.states[:failed])
  end
end
