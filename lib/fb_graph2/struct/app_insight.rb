module FbGraph2
  class Struct
    class AppInsight < Struct
      register_attributes(
        raw: [:value],
        time: [:time]
      )
    end
  end
end
