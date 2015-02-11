module FbGraph2
  class Conversation < Node
    include Edge::Tags
    include Edge::Messages

    register_attributes(
      raw: [:snippet, :message_count, :unread_count, :can_reply, :is_subscribed],
      time: [:updated_time]
    )
  end
end
