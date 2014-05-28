module FbGraph2
  class Video < Node
    register_attributes(
      raw: [:description, :embed_html, :icon, :length, :name, :picture, :source],
      time: [:created_time, :updated_time],
      profile: [:from],
      custom: [:format, :thumbnails]
    )
  end
end