module FbGraph2
  class FriendList < Node
    include Edge::Members

    register_attributes(
      raw: [:name, :list_type]
    )
  end
end