module FbGraph2
  class Photo < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext
    include Edge::Tags

    register_attributes(
      raw: [
        :backdated_time_granularity, :height, :icon, :link, :name, :page_story_id, :picture, :position, :source, :width,
        # NOTE: as cover photo
        :offset_y, :offset_x
      ],
      time: [:backdated_time, :created_time, :updated_time],
      place: [:place],
      profile: [:from],
      album: [:album],
      image_sources: [:images],
      custom: [:name_tags]
    )
  end
end