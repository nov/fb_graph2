module FbGraph2
  class Edge
    module Invited
      def invited(params = {})
        users = self.edge :invited, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end