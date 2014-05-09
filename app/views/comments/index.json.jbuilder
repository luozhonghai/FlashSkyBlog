json.array!(@comments) do |comment|
  json.extract! comment, :id, :user, :mail, :description
  json.url comment_url(comment, format: :json)
end
