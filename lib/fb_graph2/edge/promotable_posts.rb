module FbGraph2
  class Edge
    module PromotablePosts
      def promotable_posts(params = {})
        posts = self.edge :promotable_posts, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end