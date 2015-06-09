module FbGraph2
  class Edge
    module Actions
      def actions(name, params = {})
        posts = self.edge name, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end

      def action!(name, params = {})
        post = self.post params, edge: name
        Post.new(post[:id], params.merge(post)).authenticate self.access_token
      end
    end
  end
end