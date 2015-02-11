module FbGraph2
  class Struct
    class AgeRange < Struct
      register_attributes(
        raw: [:min, :max]
      )
    end
  end
end