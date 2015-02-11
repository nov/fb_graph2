module FbGraph2
  class Edge
    module Events
      def events(*args)
        params = args.extract_options!
        events = self.edge :events, params, edge_scope: args.first
        events.collect! do |event|
          Event.new(event[:id], event).authenticate self.access_token
        end
      end
    end
  end
end