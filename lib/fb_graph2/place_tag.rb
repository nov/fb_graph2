module FbGraph2
  class PlaceTag < Node
    register_attributes(
      time: [:created_time],
      page: [:place]
    )
  end
end