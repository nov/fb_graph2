module FbGraph2
  class Edge
    module Tags
      def tags(params = {})
        users = self.edge :tags, params
        users.collect! do |user|
          User.new(user[:id], user).authenticate self.access_token
        end
      end

      # NOTE: available both for create & update
      def tag!(params = {})
        self.post params, edge: :tags
      end
    end
  end
end