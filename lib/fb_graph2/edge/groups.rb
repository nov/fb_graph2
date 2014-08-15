module FbGraph2
  class Edge
    module Groups
      def groups(params = {})
        groups = self.edge :groups, params
        groups.collect! do |group|
          Group.new(group[:id], group).authenticate self.access_token
        end
      end
    end
  end
end