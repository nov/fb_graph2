module FbGraph2
  class Edge
    module Noreply
      def noreply(params = {})
        users = self.edge :noreply, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end