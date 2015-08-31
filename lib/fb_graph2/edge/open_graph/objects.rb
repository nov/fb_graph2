module FbGraph2
  class Edge
    module OpenGraph
      module Objects
        def og_object!(object_type, params = {})
          object = self.post params, edge: :objects, edge_scope: object_type
          FbGraph2::OpenGraph::Object.new(object[:id], params.merge(object)).authenticate self.access_token
        end
      end
    end
  end
end