module FbGraph2
  class Group < Node
    include Edge::Docs
    include Edge::Events
    include Edge::Feed
    include Edge::Files
    include Edge::Members
    extend Searchable

    register_attributes(
      raw: [
        :description, :email, :icon, :link, :name, :privacy,
        # NOTE: in groups edge context
        :administrator, :bookmark_order, :unread
      ],
      time: [:updated_time],
      profile: [:owner, :parent],
      photo: [:cover]
    )
  end
end