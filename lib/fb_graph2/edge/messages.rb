module FbGraph2
  class Edge
    module Messages
      def assign(attributes)
        super
        if attributes.include? :messages
          @_cached_messages = Collection.new attributes[:messages]
        end
      end

      def messages(params = {})
        messages = if @_cached_messages.present? && params.blank?
          @_cached_messages
        else
          self.edge :messages, params
        end
        messages.collect! do |message|
          Message.new(message[:id], message).authenticate self.access_token
        end
      end
    end
  end
end
