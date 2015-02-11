module FbGraph2
  class Edge
    module Applications
      def applications(params = {})
        apps = self.edge :applications, params, edge_scope: :developer
        apps.collect! do |app|
          App.new(app[:id], app).authenticate self.access_token
        end
      end
    end
  end
end