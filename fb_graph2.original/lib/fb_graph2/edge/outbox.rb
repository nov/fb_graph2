module FbGraph2
  class Edge
    module Outbox
      def outbox(params = {})
        threads = self.edge :outbox, params
        threads.collect! do |thread|
          Thread.new(thread[:id], thread).authenticate self.access_token
        end
      end
    end
  end
end