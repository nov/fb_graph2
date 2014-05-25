module FbGraph2
  class Group < Node
    register_attributes(
      raw: [
        :description, :email, :icon, :link, :name, :privacy,
        # NOTE: in groups edge context
        :administrator, :bookmark_order, :unread
      ],
      time: [:updated_time],
      custom: [:cover, :owner, :parent]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end