module FbGraph2
  class FriendList < Node
    register_attributes(
      raw: [:name, :list_type]
    )
  end
end