class Charge < ActiveRecord::Base
  belongs_to :account
  has_many :charge_states

  default_scope { order("created_at asc") }

  scope :all_for_account, ->(account) { where(:account => account) }

  scope :find_for_account, ->(account, charge_id) {
    all_for_account(account).find(charge_id)
  }

  scope :all_in_progress, -> {
    where <<-eos
      id in
        (select cs1.charge_id from charge_states as cs1
         left join charge_states as cs2
         on (cs1.charge_id = cs2.charge_id and cs1.created_at < cs2.created_at)
         where cs2.id is null and cs1.state not in (#{ChargeState.final_states.join(",")}))
    eos
  }

  scope :all_finalized, -> {
    where <<-eos
      id in
        (select cs1.charge_id from charge_states as cs1
         left join charge_states as cs2
         on (cs1.charge_id = cs2.charge_id and cs1.created_at < cs2.created_at)
         where cs2.id is null and cs1.state in (#{ChargeState.final_states.join(",")}))
    eos
  }

  scope :all_with_state, ->(state) {
    where <<-eos
      id in
        (select cs1.charge_id from charge_states as cs1
         left join charge_states as cs2
         on (cs1.charge_id = cs2.charge_id and cs1.created_at < cs2.created_at)
         where cs2.id is null and cs1.state = #{ChargeState.states[state]})
    eos
  }

  before_create :processing!

  def readonly?
    persisted?
  end

  def states
    charge_states
  end

  def state
    states.last
  end

  def processing!
    states.build(:state => ChargeState.states[:processing], :created_at => created_at)
  end

  def processed!
    states.create(:state => ChargeState.states[:processed])
  end

  def failed!
    states.create(:state => ChargeState.states[:failed])
  end
end
