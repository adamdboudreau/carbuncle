json.array!(@products) do |product|
  json.extract! product, :name, :description, :cost
  json.url product_url(product, format: :json)
end
