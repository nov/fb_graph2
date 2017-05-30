module FbGraph2
  class PlaceTag < Node
    register_attributes(
      time: [:created_time],
      place: [:place]
    )
  end
end