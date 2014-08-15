module FbGraph2
  class Edge
    module Inbox
      def inbox(params = {})
        threads = self.edge :inbox, params
        threads.collect! do |thread|
          Thread.new(thread[:id], thread).authenticate self.access_token
        end
      end
    end
  end
end