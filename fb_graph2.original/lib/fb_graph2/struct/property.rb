module FbGraph2
  class Struct
    class Property < Struct
      register_attributes(
        raw: [:name, :text, :href]
      )
    end
  end
end