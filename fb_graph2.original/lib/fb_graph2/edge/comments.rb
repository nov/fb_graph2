module FbGraph2
  class Edge
    module Comments
      def assign(attributes)
        super
        if attributes.include? :comments
          @_cached_comments = Collection.new attributes[:comments]
        end
      end

      def comments(params = {})
        comments = if @_cached_comments.present? && params.blank?
          @_cached_comments
        else
          self.edge :comments, params
        end
        comments.collect! do |comment|
          Comment.new(comment[:id], comment).authenticate self.access_token
        end
      end

      def comment!(params = {})
        comment = self.post params, edge: :comments
        Comment.new(comment[:id], params.merge(comment)).authenticate self.access_token
      end
    end
  end
end