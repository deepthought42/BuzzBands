json.array!(@promoters) do |promoter|
  json.extract! promoter, :id, :string
  json.url promoter_url(promoter, format: :json)
end
