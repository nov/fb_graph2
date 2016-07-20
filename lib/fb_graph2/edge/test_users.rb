module FbGraph2
  class Edge
    module TestUsers
      def test_users(params = {})
        users = self.edge :accounts, params, edge_scope: :'test-users'
        users.collect! do |user|
          User.new(user[:id], user)
        end
      end

      def test_users!(params = {})
        user = self.post params, edge: :accounts, edge_scope: :'test-users'
        params.delete(:access_token)
        User.new(user[:id], params.merge(user))
      end
    end
  end
end
