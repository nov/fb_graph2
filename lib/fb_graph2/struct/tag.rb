module FbGraph2
  class Struct
    class Tag < Struct
      register_attributes(
        raw: [:name]
      )
    end
  end
end