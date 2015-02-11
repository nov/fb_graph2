module FbGraph2
  class Struct
    class Picture < Struct
      register_attributes(
        raw: [:url, :is_silhouette, :height, :width]
      )
    end
  end
end