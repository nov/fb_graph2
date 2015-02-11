module FbGraph2
  class Struct
    class Education < Struct
      register_attributes(
        raw: [:type],
        page: [:school, :year, :degree],
        pages: [:classes, :concentration]
      )
    end
  end
end
