module FbGraph2
  class Struct
    class Privacy < Struct
      register_attributes(
        raw: [:description, :value, :friends, :allow, :deny]
      )
    end
  end
end