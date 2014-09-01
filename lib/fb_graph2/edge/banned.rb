module FbGraph2
  class Edge
    module Banned
      def banned(params = {})
        users = self.edge :banned, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end

      def banned?(user, params = {})
        users = self.edge :banned, params, edge_scope: user
        users.present?
      end

      def ban!(user, params = {})
        self.post params.merge(
          uid: Util.as_identifier(user)
        ), edge: :banned
      end

      def unban!(user, params = {})
        self.delete params.merge(
          uid: Util.as_identifier(user)
        ), edge: :banned
      end
    end
  end
end