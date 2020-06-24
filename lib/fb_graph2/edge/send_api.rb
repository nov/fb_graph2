module FbGraph2
  class Edge
    module SendApi
      def message!(params = {})
        message = self.post params, edge: :messages
        Message.new(message[:message_id], params.merge(message)).authenticate self.access_token
      end
    end
  end
end
