class CreateChargeStates < ActiveRecord::Migration
  def change
    create_table :charge_states do |t|
      t.integer :charge_id
      t.integer :state
      t.datetime :created_at
    end

    add_index :charge_states, [:charge_id, :created_at], :unique => true
  end
end
