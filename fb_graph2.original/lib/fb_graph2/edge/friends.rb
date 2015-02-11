module FbGraph2
  class Edge
    module Friends
      def friends(params = {})
        users = self.edge :friends, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end

      def friend?(user, params = {})
        users = self.edge :friends, params, edge_scope: user
        users.present?
      end
    end
  end
end