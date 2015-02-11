module FbGraph2
  class Edge
    module TestUsers
      def test_users(params = {})
        users = self.edge :accounts, params, edge_scope: :'test-users'
        users.collect! do |user|
          User.new(user[:id], user)
        end
      end
    end
  end
end