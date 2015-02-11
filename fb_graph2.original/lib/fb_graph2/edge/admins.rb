module FbGraph2
  class Edge
    module Admins
      def admins(params = {})
        users = self.edge :admins, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end

      def admin?(user, params = {})
        users = self.edge :admins, params, edge_scope: user
        users.present?
      end
    end
  end
end