module FbGraph2
  class Struct
    class ImageSource < Struct
      register_attributes(
        raw: [:height, :source, :width]
      )
    end
  end
end