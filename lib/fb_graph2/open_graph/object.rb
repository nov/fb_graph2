module FbGraph2
  module OpenGraph
    class Object < Node
      register_attributes(
        raw: [:title, :type, :url]
      )
    end
  end
end