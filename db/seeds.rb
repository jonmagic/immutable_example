# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t = 2_000_000.seconds.ago

100.times do
  account = Account.create :name => Faker::Name.name, :created_at => t - 1.second
  plan_amount_in_cents = [700, 1200, 2200, 2500].sample

  10.times do
    charge = Charge.create \
      :account => account,
      :amount_in_cents => plan_amount_in_cents,
      :created_at => t

    action = [nil, :processed!, :failed!].sample
    charge.send(action) if action

    t += 1.second
  end
end
