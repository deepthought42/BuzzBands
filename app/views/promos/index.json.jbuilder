json.array!(@promos) do |promo|
  json.extract! promo, :id, :string, :string, :timestamp, :timestamp
  json.url promo_url(promo, format: :json)
end
