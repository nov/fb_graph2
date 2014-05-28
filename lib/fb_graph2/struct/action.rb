module FbGraph2
  class Struct
    class Action < Struct
      register_attributes(
        raw: [:name, :link]
      )
    end
  end
end