module FbGraph2
  class Edge
    module Statuses
      def statuses(params = {})
        posts = self.edge :statuses, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end