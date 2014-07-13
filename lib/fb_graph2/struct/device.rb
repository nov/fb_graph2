module FbGraph2
  class Struct
    class Device < Struct
      register_attributes(
        raw: [:hardware, :os]
      )
    end
  end
end