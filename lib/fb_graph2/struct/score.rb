module FbGraph2
  class Struct
    class Score < Struct
      register_attributes(
        raw: [:score],
        user: [:user],
        app: [:application]
      )
    end
  end
end