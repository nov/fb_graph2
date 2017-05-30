module FbGraph2
  class Comment < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext

    register_attributes(
      raw: [:can_comment, :can_remove, :comment_count, :like_count, :message, :user_likes, :is_hidden, :can_hide],
      time: [:created_time],
      comment: [:parent],
      profile: [:from],
      profiles: [:message_tags],
      custom: [:attachment]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end