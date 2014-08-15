module FbGraph2
  class Edge
    module Banned
      def banned(params = {})
        users = self.edge :banned, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end