module FbGraph2
  module Util
    module_function

    def as_identifier(object)
      if object.respond_to? :id
        object.id
      elsif object.respond_to? :as_identifier
        object.as_identifier
      else
        object
      end
    end
  end
end
