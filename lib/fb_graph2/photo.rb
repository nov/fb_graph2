module FbGraph2
  class Photo < Node
    register_attributes(
      raw: [:backdated_time_granularity, :height, :icon, :link, :name, :page_story_id, :picture, :position, :source, :width],
      time: [:backdated_time, :created_time, :updated_time],
      page: [:place],
      profile: [:from],
      album: [:album],
      custom: [:images, :name_tags]
    )
  end
end