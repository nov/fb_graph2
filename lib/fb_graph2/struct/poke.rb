module FbGraph2
  class Struct
    class Poke < Struct
      register_attributes(
        time: [:created_time],
        user: [:from, :to]
      )
    end
  end
end