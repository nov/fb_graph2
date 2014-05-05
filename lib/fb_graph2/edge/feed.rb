module FbGraph2
  class Edge
    module Feed
      def feed(params = {})
        posts = self.edge :feed, params
        posts.collect do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end