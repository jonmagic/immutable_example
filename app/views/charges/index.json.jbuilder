json.array!(@charges) do |charge|
  json.extract! charge, :id, :amount_in_cents, :account_id, :created_at
  json.url charge_url(charge, format: :json)
end
