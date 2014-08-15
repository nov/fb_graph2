module FbGraph2
  class Edge
    module Posts
      def posts(params = {})
        posts = self.edge :posts, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end