module FbGraph2
  class Struct
    class Poke < Struct
      register_attributes(
        raw: [:score],
        user: [:user],
        application: [:application]
      )
    end
  end
end