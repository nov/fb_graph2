module FbGraph2
  class Edge
    module OpenGraph
      module Actions
        def og_actions(action_type, params = {})
          actions = self.edge action_type, params
          actions.collect! do |action|
            FbGraph2::OpenGraph::Action.new(action[:id], action).authenticate self.access_token
          end
        end

        def og_action!(action_type, params = {})
          action = self.post params, edge: action_type
          FbGraph2::OpenGraph::Action.new(action[:id], params.merge(action)).authenticate self.access_token
        end
      end
    end
  end
end