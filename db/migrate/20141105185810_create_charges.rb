class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :amount_in_cents
      t.integer :account_id
      t.datetime :created_at
    end
  end
end
