module FbGraph2
  class Album < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext
    include Edge::Picture
    include Edge::Photos
    include Edge::SharedPosts

    register_attributes(
      raw: [:can_upload, :count, :cover_photo, :description, :link, :location, :name, :privacy, :type],
      time: [:created_time, :updated_time],
      user: [:from],
      page: [:place]
    )
  end
end