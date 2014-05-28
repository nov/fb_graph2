module FbGraph2
  class Group < Node
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