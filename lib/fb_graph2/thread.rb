module FbGraph2
  class Thread < Node
    include Edge::Messages
    alias_method :comments, :messages

    register_attributes(
      raw: [:unread, :unseen],
      time: [:updated_time],
      profiles: [:to],
      messages: [:comments]
    )
  end
end