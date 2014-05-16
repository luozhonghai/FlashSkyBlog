json.array!(@pictures) do |picture|
  json.extract! picture, :id, :title, :name, :content_type, :data
  json.url picture_url(picture, format: :json)
end
