module FbGraph2
  class Edge
    module SharedPosts
      def shared_posts(params = {})
        posts = self.edge :posts, params
        posts.collect do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
      alias_method :sharedposts, :shared_posts
    end
  end
end