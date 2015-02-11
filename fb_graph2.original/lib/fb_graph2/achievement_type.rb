module FbGraph2
  class AchievementType < Node
    register_attributes(
      raw: [:type, :title, :url, :description, :is_scraped],
      time: [:updated_time, :created_time],
      picture: [:image],
      app: [:application],
      custom: [:data, :context]
    )
  end
end