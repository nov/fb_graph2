module FbGraph2
  class Edge
    module Blocked
      def blocked(params = {})
        users = self.edge :blocked, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end

      def blocked?(user, params = {})
        users = self.edge :blocked, params, edge_scope: user
        users.present?
      end

      def block!(user, params = {})
        self.post params.merge(
          user: Util.as_identifier(user)
        ), edge: :blocked
      end

      def unblock!(user, params = {})
        self.delete params.merge(
          user: Util.as_identifier(user)
        ), edge: :blocked
      end
    end
  end
end