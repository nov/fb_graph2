module FbGraph2
  class Struct
    class Setting < Struct
      register_attributes(
        raw: [:setting, :value]
      )
    end
  end
end