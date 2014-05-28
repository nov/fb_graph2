module FbGraph2
  class Struct
    class InvitableFriend < Struct
      register_attributes(
        raw: [:id, :name],
        picture: [:picture]
      )
    end
  end
end