module FbGraph2
  class Edge
    module Roles
      def roles(params = {})
        roles = self.edge :roles, params
        roles.collect do |role|
          Struct::Role.new role
        end
      end
    end
  end
end