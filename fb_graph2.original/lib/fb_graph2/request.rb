module FbGraph2
  class Request < Node
    register_attributes(
      raw: [:message],
      time: [:created_time],
      app: [:application],
      user: [:to, :from]
    )
  end
end