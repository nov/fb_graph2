module FbGraph2
  module Util
    module_function

    def as_identifier(object)
      if object.respond_to? :id
        object.id
      else
        object
      end
    end
  end
end
