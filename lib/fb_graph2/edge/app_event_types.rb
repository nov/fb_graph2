module FbGraph2
  class Edge
    module AppEventTypes
      def app_event_types(params = {})
        types = self.edge :app_event_types, params
        types.collect! do |type|
          Struct::AppEventType.new type
        end
      end
    end
  end
end