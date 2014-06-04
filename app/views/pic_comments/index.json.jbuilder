json.array!(@pic_comments) do |pic_comment|
  json.extract! pic_comment, :id, :user, :description, :user_id, :picture_id
  json.url pic_comment_url(pic_comment, format: :json)
end
