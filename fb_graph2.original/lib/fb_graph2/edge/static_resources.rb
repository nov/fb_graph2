module FbGraph2
  class Edge
    module StaticResources
      def static_resources(params = {})
        resources = self.edge :staticresources, params
        resources.collect! do |resource|
          Struct::StaticResource.new resource
        end
      end
      alias_method :staticresources, :static_resources
    end
  end
end