module FbGraph2
  class Edge
    module Conversations
      def conversations(params = {})
        conversations = self.edge :conversations, params
        conversations.collect! do |conversation|
          Conversation.new(conversation[:id], conversation).authenticate self.access_token
        end
      end
    end
  end
end
