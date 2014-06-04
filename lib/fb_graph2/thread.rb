module FbGraph2
  class Thread < Node
    register_attributes(
      raw: [:unread, :unseen],
      time: [:updated_time],
      profiles: [:to],
      messages: [:comments]
    )
  end
end