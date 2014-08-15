module FbGraph2
  class Struct
    class Friend < Struct
      register_attributes(
        raw: [:id, :name], # NOTE: this 'id' isn't user_id, but a token for invitation/tagging.
        picture: [:picture]
      )
    end
  end
end