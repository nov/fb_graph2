module FbGraph2
  class Edge
    module Permissions
      def permissions(params = {})
        permissions = self.edge :permissions, params
        permissions.collect! do |permission|
          Struct::Permission.new permission
        end
      end
    end
  end
end