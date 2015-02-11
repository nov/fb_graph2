module FbGraph2
  class Edge
    module Maybe
      def maybe(params = {})
        users = self.edge :maybe, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end