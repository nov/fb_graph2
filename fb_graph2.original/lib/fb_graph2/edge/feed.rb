module FbGraph2
  class Edge
    module Feed
      def feed(params = {})
        posts = self.edge :feed, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end

      def feed!(params = {})
        post = self.post params, edge: :feed
        Post.new(post[:id], params.merge(post)).authenticate self.access_token
      end
    end
  end
end