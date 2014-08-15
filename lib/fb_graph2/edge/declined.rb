module FbGraph2
  class Edge
    module Declined
      def declined(params = {})
        users = self.edge :declined, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end