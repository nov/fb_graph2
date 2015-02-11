module FbGraph2
  class Struct
    class Permission < Struct
      register_attributes(
        raw: [:permission, :status]
      )
    end
  end
end