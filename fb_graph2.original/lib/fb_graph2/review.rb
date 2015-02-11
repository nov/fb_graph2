module FbGraph2
  class Review < Node
    register_attributes(
      raw: [:message, :rating],
      time: [:created_time],
      app: [:to],
      user: [:from]
    )
  end
end