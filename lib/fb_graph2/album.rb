module FbGraph2
  class Album < Node
    register_attributes(
      raw: [:can_upload, :count, :cover_photo, :description, :link, :location, :name, :privacy, :type],
      time: [:created_time, :updated_time],
      user: [:from],
      page: [:place]
    )
  end
end