json.array!(@paintings) do |painting|
  json.extract! painting, :image, :title, :caption, :ordinal
  json.url painting_url(painting, format: :json)
end
