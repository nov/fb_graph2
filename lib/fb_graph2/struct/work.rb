module FbGraph2
  class Struct
    class Work < Struct
      register_attributes(
        page: [:employer, :location, :position],
        pages: [:projects],
        time: [:start_date, :end_date]
      )
    end
  end
end