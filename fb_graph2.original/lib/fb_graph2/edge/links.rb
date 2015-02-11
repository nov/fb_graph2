module FbGraph2
  class Edge
    module Links
      def links(params = {})
        posts = self.edge :links, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end