module FbGraph2
  class Edge
    module TestUser
      def test_user(params = {})
        params[:installed] = true
        new_user = self.edge :accounts, params, edge_scope: :'test-users'
        new_user.collect! do |user|
          User.new(user[:id], user)
        end
      end
    end
  end
end
