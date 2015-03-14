module FbGraph2
  class Message < Node
    register_attributes(
      raw: [:message, :subject],
      time: [:created_time],
      profile: [:from],
      profiles: [:to],
      tags: [:tags]
    )
  end
end