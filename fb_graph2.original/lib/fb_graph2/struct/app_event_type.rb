module FbGraph2
  class Struct
    class AppEventType < Struct
      register_attributes(
        raw: [:event_name, :display_name, :description],
        custom: [:parameters]
      )

      class Parameter < Struct
        register_attributes(
          raw: [:parameter_name, :display_name, :description]
        )
      end

      def initialize(attributes = {})
        super
        if attributes.include? :parameters
          self.parameters = Collection.new(attributes[:parameters]).collect! do |param|
            Parameter.new param
          end
        end
      end
    end
  end
end