module FbGraph2
  class Comment < Node
    register_attributes(
      raw: [:can_comment, :can_remove, :comment_count, :like_count, :message, :user_likes],
      time: [:created_time],
      user: [:from],
      custom: [:attachment, :message_tags, :parent]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end