module FbGraph2
  class Edge
    module Members
      def members(params = {})
        users = self.edge :members, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end