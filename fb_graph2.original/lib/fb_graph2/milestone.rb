module FbGraph2
  class Milestone < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext
    include Edge::Photos

    register_attributes(
      raw: [:title, :description],
      time: [:created_time, :updated_time, :start_time, :end_time],
      page: [:from]
    )
  end
end