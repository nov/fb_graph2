module FbGraph2
  class Edge
    module Tagged
      def tagged(params = {})
        posts = self.edge :tagged, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end