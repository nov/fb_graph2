module FbGraph2
  class Edge
    module Messages
      def messages(params = {})
        messages = self.edge :conversations, params
        messages.collect! do |message|
          Message.new(message[:id], message).authenticate message[:access_token]
        end
      end
    end
  end
end