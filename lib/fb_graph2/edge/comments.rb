module FbGraph2
  class Edge
    module Comments
      def comments(params = {})
        comments = self.edge :comments, params
        comments.collect do |comment|
          Comment.new(comment[:id], comment).authenticate self.access_token
        end
      end

      def comment!(params = {})
        comment = self.post params, edge: :comments
        Comment.new(comment[:id], comment.merge(params)).authenticate self.access_token
      end
    end
  end
end