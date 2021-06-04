module FbGraph2
  class Edge
    module ScheduledPosts
      def scheduled_posts(params = {})
        posts = self.edge :scheduled_posts, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end