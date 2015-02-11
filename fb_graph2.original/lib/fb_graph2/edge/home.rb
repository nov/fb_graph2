module FbGraph2
  class Edge
    module Home
      def home(params = {})
        posts = self.edge :home, params
        posts.collect! do |post|
          Post.new(post[:id], post).authenticate self.access_token
        end
      end
    end
  end
end