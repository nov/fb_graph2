module FbGraph2
  class Message < Node
    register_attributes(
      raw: [:message],
      time: [:created_time],
      profile: [:from]
    )
  end
end