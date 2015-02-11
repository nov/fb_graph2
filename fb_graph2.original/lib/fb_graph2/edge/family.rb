module FbGraph2
  class Edge
    module Family
      def family(params = {})
        users = self.edge :family, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end
    end
  end
end