module FbGraph2
  class Struct
    class Education < Struct
      register_attributes(
        raw: [:type],
        page: [:school, :year],
        pages: [:concentration]
      )
    end
  end
end